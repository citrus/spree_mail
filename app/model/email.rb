class Email < ActiveRecord::Base

  include SpreeMail::HasToken

  validates :to,      :presence => true, :if => Proc.new{|email| email.state == "address" }
  validates :subject, :presence => true
  validates :body,    :presence => true
  
  attr_reader :sent_at
    
  state_machine :state, :initial => :layout do
          
    event :next do
      transition :from => :layout,  :to => :address
      transition :from => :address, :to => :edit
      transition :from => :edit,    :to => :preview
      transition :from => :preview, :to => :sent
    end                   
    
    event :previous do
      transition :from => :preview, :to => :edit
      transition :from => :edit,    :to => :address
      transition :from => :address, :to => :layout
    end    
    
    event :change_layout do
      transition :to => :layout, :if => :allow_alteration?
    end
    
    event :readdress do
      transition :to => :address, :if => :allow_alteration?
    end
    
    event :preview do
      transition :from => :edit, :to => :preview
    end
    
    event :revise do
      transition :from => :preview, :to => :edit
    end
    
    after_transition :to => :sent, :do => :deliver!

  end
  
  
  
  def allow_alteration?
    !sent?
  end
    
  def sent?
    !@sent_at.nil?
  end
  
  
  
  
  
  def to=(value)
    value = {} unless value.is_a? Hash
    value.delete("0")
    return false if value.empty?    
    write_attribute :to, value.inspect
  end
  
  def from
    MailMethod.current.preferred_mails_from rescue "no-reply@spree-mail-example.com"
  end
  
  def recipients
    hash = eval(read_attribute(:to)) rescue {}  
    hash.values  
  end
  
  def recipient_list
    recipients.join(", ")
  end
  
  def render(attribute, subscriber)
    Mustache.render(self.send(attribute), subscriber.attributes)
  end

  def deliver!
    @sent_at = Time.now
    count = 0
    recipients.each do |email|
      subscriber = Subscriber.find_by_email(email) rescue nil
      if subscriber
        mail = EmailMailer.with_layout(self, subscriber)
        count += 1 if mail && mail.deliver!
      end
    end   
    return 0 < count, count
  end
  
  
  #private
  
    #def initialize(params)
    #  @state = "layout"
    #  super(params)
    #end
      
  class << self
    
    def new(parameters={})
      parameters ||= {}
      super(parameters.reverse_merge!(:body => template))
    end
  
    def template
      txt=<<TXT
Hello {{name}},
  

  
Regards,

#{Spree::Config[:site_name]}
    
TXT
    end
    
    
  end

end
