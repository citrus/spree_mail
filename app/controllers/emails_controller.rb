class EmailsController < Spree::BaseController
      
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  
  def show
    @subscriber = Subscriber.find_by_token(params[:token])
    @email = Email.find_by_token(params[:id])
    
    return redirect_to new_subscriber_path unless @email.recipients.include?(@subscriber.email)
    
    @email_subject = @email.render(:subject, @subscriber)
    @text          = @email.render(:body,    @subscriber)
    @base_url      = "http://#{Spree::Config[:site_url]}"
    
    render :layout => 'email', :text => simple_format(@text)    
  end
  
end