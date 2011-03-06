class Email < ActiveRecord::Base

  include SpreeMail::HasToken

  validates :to,      :presence => true, :if => :state_is_address?
  validates :subject, :presence => true, :if => :state_is_edit?
  validates :body,    :presence => true, :if => :state_is_edit?
  
  
  # Method missing for validation conditionals
  def method_missing(method, *args, &block)
    if matches = method.to_s.match(/state_is_([a-z]+)\?$/)
      state.to_s == matches[1].to_s
    else
      super
    end
  end
  
      
  
  state_machine :state, :initial => :layout do
       
    event :next do
      transition :layout => :address, :address => :edit, :edit => :preview, :preview => :sent
    end                   
    
    event :previous do
      transition :preview => :edit, :edit => :address, :address => :layout, :unless => :sent?
    end    
    
    event :change_layout do
      transition :to => :layout, :unless => :sent?
    end
    
    event :readdress do
      transition :from => [:edit, :preview], :to => :address, :unless => :sent?
    end
    
    event :preview do
      transition :edit => :preview
    end
    
    event :revise do
      transition :preview => :edit
    end
    
    after_transition :to => :sent, :do => :deliver!

  end
  
  
  
  # An attribute writer that ensures a non-empty hash  
  def to=(value)
    value = {} unless value.is_a? Hash
    value.delete("0")
    return false if value.empty?    
    write_attribute :to, value.inspect
  end
  
  # A shortcut used in the EmailMailer
  def from
    MailMethod.current.preferred_mails_from rescue "no-reply@spree-mail-example.com"
  end
  
  # A hash of ids and emails
  def recipients
    hash = eval(read_attribute(:to)) rescue {}  
    hash.values  
  end
  
  # A comma seperated list of email addresses
  def recipient_list
    recipients.join(", ")
  end
  
  # Renders an attribute against a subscriber.
  # Used for :subject and :body 
  def render(attribute, subscriber)
    Mustache.render(self.send(attribute), subscriber.attributes)
  end

  # Updates sent at to now and shoots an email to each recipient
  def deliver!
    update_attributes(:sent_at => Time.now)
    count = 0
    recipients.each do |email|
      subscriber = Subscriber.find_by_email(email) rescue nil
      if subscriber
        mail = EmailMailer.with_layout(self, subscriber)
        count += 1 if mail && mail.deliver!
      end
    end
    0 < count
  end
  
  # Returns true unless sent at is nil
  def sent?
    !self.sent_at.nil?
  end
  
      
  class << self
    
    # Builds a new email with defaults
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
