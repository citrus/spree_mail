class Admin::EmailsController < Admin::BaseController
  
  resource_controller
  
  before_filter :get_subscribers, :only => [:new, :create, :edit, :update]
  before_filter :get_layouts, :only => [:new, :create, :edit, :update]
  
  new_action.before do
    @layouts = EmailLayout.all
  end
  
  create.success.wants.html {
    cookies[:current_email] = @email.token
    redirect_to admin_email_state_path("address") 
  }


  def edit
    @email = object
    @email.state = params[:state] if params[:state]
  end
  

  update.success.wants.html {
    @email.next!
    redirect_to admin_email_state_path(@email.state)
  }


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
    
    def get_layouts  
      @layouts = EmailLayout.all
    end
    
    def object
      @object ||= Email.find_by_token(params[:id] || cookies[:current_email])
    end
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "subject.asc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    end
 
end
