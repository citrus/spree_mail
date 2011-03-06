class Admin::EmailLayoutsController < Admin::BaseController
  
  resource_controller
  
  destroy.success.wants.js { render_js_for_destroy }

  private
    
    def collection
      params[:search] ||= {}
      params[:search][:meta_sort] ||= "name.asc"
      @search = end_of_association_chain.metasearch(params[:search])
      @collection = @search.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    end
 
end
