class SubscribersController < Spree::BaseController

  before_filter :get_subscriber, :only => [:show, :unsubscribe]
  
  def index
    redirect_to new_subscriber_path
  end
  
  def new
    @subscriber = Subscriber.new
  end
  
  def show
  end
  
  def create
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.valid? && @subscriber.save
      flash[:notice] = "Thanks for signing up for our newsletter!"
      redirect_to new_subscriber_path
    else
      flash[:error] = "Sorry, we could not sign you up."
      render :action => 'new'
    end
  end
  
  def unsubscribe
    if @subscriber.email == params[:subscriber][:email] && @subscriber.unsubscribe!
      flash[:notice] = "You were successfully unsubscribed from the mailing list."
    else
      flash[:error]  = "We're sorry, you could not be unsubscribed at this time."
    end
    redirect_to new_subscriber_path
  end
  
  private
  
    def get_subscriber
      @subscriber = Subscriber.find_by_token(params[:id])
    end
  
end