UsersController.instance_eval do
  
  before_filter :get_subscriber, :only => :show
  
end

UsersController.class_eval do
  
  def get_subscriber
    @subscriber = Subscriber.find_by_email(current_user.email) if current_user
  end
  
end