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
      flash[:notice] = I18n.t( :subscribe_thanks)
      redirect_to new_subscriber_path
    else
      flash[:error] = I18n.t( :subscribe_failed)
      render :action => 'new'
    end
  end
  
  def unsubscribe
    if @subscriber.email == params[:subscriber][:email] && @subscriber.unsubscribe!
      flash[:notice] = I18n.t(:unsubscribe_success_public)
    else
      flash[:error]  = I18n.t(:unsubscribe_failed_public)
    end
    redirect_to new_subscriber_path
  end
  
  private
  
    def get_subscriber
      @subscriber = Subscriber.find_by_token(params[:id])
    end
  
end
