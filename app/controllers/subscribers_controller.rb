class SubscribersController < Spree::BaseController
  
  def index
    redirect_to new_subscriber_path
  end
  
  def new
    @subscriber = Subscriber.new
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
  
end