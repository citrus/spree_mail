class Admin::SubscribersController < Admin::BaseController
  
  resource_controller
  
  destroy.success.wants.js { render_js_for_destroy }

  create.response do |wants|
    wants.html { redirect_to admin_subscribers_path }
  end
  
  update.response do |wants|
    wants.html { redirect_to admin_subscribers_path }
  end

  def resubscribe
    @subscriber = object
    if @subscriber.resubscribe!
      flash[:notice] = t('resubscribe_success')
    else
      flash[:error] = t('resubscribe_failed')
    end
    redirect_to request.referer
  end
    
  def unsubscribe
    @subscriber = object
    if @subscriber.unsubscribe!
      flash[:notice] = t('unsubscribe_success')
    else
      flash[:error] = t('unsubscribe_failed')
    end
    redirect_to request.referer
  end

  def unsubscribed
    params[:search] ||= {}
    params[:search][:unsubscribed_at_is_not_null] = true
    @subscribers = collection
    render :template => 'admin/subscribers/index'
  end

  private
  
    def object
      @object ||= Subscriber.find_by_token(params[:id])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "name.asc"
      unless params[:search].has_key?(:unsubscribed_at_is_not_null)
        params[:search][:unsubscribed_at_is_null] = true
      end    
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    end
    
end