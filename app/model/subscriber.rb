class Subscriber < ActiveRecord::Base
  
  default_scope order(:name)
  
  validates :name,  :presence => true
  validates :email, :format => Devise.email_regexp, :uniqueness => true
  
end