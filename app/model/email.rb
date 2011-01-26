class Email < ActiveRecord::Base
  
  validates :subject, :presence => true
  validates :body, :presence => true

  def to=(value)
  
    puts "----"
    puts value
  
    value = {} unless value.is_a? Hash
    value.delete("0")
    write_attribute :to, value.inspect
  end
  
  def recipients
    hash = eval(read_attribute(:to)) rescue {}  
    hash.values  
  end
  
  def recipient_list
    recipients.join(", ")
  end

end