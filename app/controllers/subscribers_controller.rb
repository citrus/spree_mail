class SubscribersController < Spree::BaseController

  before_filter :get_subscriber, :only => [:show, :unsubscribe]
  
  def new
    @subscriber = Subscriber.new
  end
  
  def show
    return redirect_to(new_subscriber_path) unless @subscriber && @subscriber.active?
  end
  
  def create
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.valid? && @subscriber.save
      flash[:notice] = t('subscribe_success')
      redirect_to new_subscriber_path
    else
      flash[:error] = t('subscribe_failed')
      render :action => 'new'
    end
  end
  
  def unsubscribe
    if @subscriber.email == params[:subscriber][:email] && @subscriber.unsubscribe!
      flash[:notice] = t('unsubscribe_success_public')
      redirect_to new_subscriber_path
    else
      flash[:error]  = t('unsubscribe_failed_public')    
      redirect_to subscriber_path(@subscriber)
    end
  end
    
  private
  
    def get_subscriber
      @subscriber = Subscriber.find_by_token(params[:id])
    end
  
end
