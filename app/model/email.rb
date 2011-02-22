class Email < ActiveRecord::Base

  include SpreeMail::HasToken

  validates :to,      :presence => true
  validates :subject, :presence => true
  validates :body,    :presence => true
  
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
