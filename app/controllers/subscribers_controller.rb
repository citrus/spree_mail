class SubscribersController < Spree::BaseController

  before_filter :get_subscriber, :only => [:show, :unsubscribe, :resubscribe]
  
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
      redirect_to current_user ? account_path : new_subscriber_path
    else
      flash[:error]  = t('unsubscribe_failed_public')    
      redirect_to subscriber_path(@subscriber)
    end
  end
  
  def resubscribe
    if @subscriber.resubscribe!
      flash[:notice] = t('subscribe_success_public')
      redirect_to current_user ? account_path : subscriber_path
    else
      flash[:error]  = t('subscribe_failed_public')    
      redirect_to resubscribe_subscriber_path(@subscriber)
    end
  end
  
  def subscribe
    return redirect_to(new_subscriber_path) unless current_user
    @subsciber = Subscriber.find_by_email(current_user.email) rescue nil
    return redirect_to(account_path) if @subscriber && @subscriber.active?
    @subscriber = Subscriber.new(:email => current_user.email)    
    if @subscriber.save
      flash[:notice] = t('subscribe_success_public')
      redirect_to account_path
    else
      flash[:error]  = t('subscribe_failed_public')
      redirect_to new_subscriber_path
    end
    
  end
    
  private
  
    def get_subscriber
      @subscriber = Subscriber.find_by_token(params[:id])
      return redirect_to(new_subscriber_path) unless @subscriber
    end
  
end
