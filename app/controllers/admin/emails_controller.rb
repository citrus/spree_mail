class Admin::EmailsController < Admin::BaseController
  
  resource_controller
  
  before_filter :get_subscribers, :only => [:new, :create, :edit, :update]
  
  destroy.success.wants.js { render_js_for_destroy }

  def deliver
    @email = object
    sent, count = @email.deliver!
    if sent
      flash[:notice] = t('delivery_success', count)
    else
      flash[:error] = t('delivery_failed', count)
    end
    redirect_to admin_email_path(@email)
  end 

  private
  
    def get_subscribers
     @subscribers = Subscriber.active
    end
    
    def object
      @object ||= Email.find_by_token(params[:id])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "subject.asc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    end
 
end
