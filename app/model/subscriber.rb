class Subscriber < ActiveRecord::Base

  include SpreeMail::HasToken
  
  scope :active, where("unsubscribed_at IS NULL").order(:name)
  scope :unsubscribed, where("unsubscribed_at IS NOT NULL").order(:name)
  
  validates :email, :email => true, :uniqueness => true
    
  # Determines if the user has unsubscribed or not
  def active?
    unsubscribed_at.to_s.empty?
  end
  
  # Reactivates the user by setting their unsubscribed_at to nil
  def resubscribe!
    return true if active?
    self.unsubscribed_at = nil
    save
  end
  
  # Unsubscribes the user by setting their unsubscribed timestamp
  def unsubscribe!
    return true unless active?
    self.unsubscribed_at = Time.now
    save
  end
  
  # Cleans and sets the subscribers email attribute
  def email=(value)
    write_attribute :email, value.strip.downcase
  end

end