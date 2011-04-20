class Subscriber < ActiveRecord::Base

  include SpreeMail::HasToken
  
  # ?? Do we need these scopes anywhere else 
  # -> DRY (Later task)
  scope :active, where("unsubscribed_at IS NULL").order(:name)
  scope :unsubscribed, where("unsubscribed_at IS NOT NULL").order(:name)
  
  #validates :name,  :presence => true
  validates :email, :email => true, :uniqueness => true
    
  def active?
    unsubscribed_at.to_s.empty?
  end
  
  def resubscribe!
    return true if active?
    self.unsubscribed_at = nil
    save
  end
  
  def unsubscribe!
    return true unless active?
    self.unsubscribed_at = Time.now
    save
  end
  
  def email=(value)
    write_attribute :email, value.strip.downcase
  end

end
