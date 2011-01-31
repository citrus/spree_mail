class EmailsController < Spree::BaseController
      
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  
  def show
    @subscriber = Subscriber.find_by_token(params[:subscriber])
    @email      = Email.find_by_token(params[:email])
    if @email.recipients.include?(@subscriber.email)  
      @email_subject = @email.render(:subject, @subscriber)
      @text          = @email.render(:body,    @subscriber)
      @base_url      = "http://#{Spree::Config[:site_url]}"
      render :layout => 'email', :text => simple_format(@text)    
    else
      flash[:error] = t('unintened_email_view')
      redirect_to new_subscriber_path
    end
  end
  
end