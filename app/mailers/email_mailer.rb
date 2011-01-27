class EmailMailer < ActionMailer::Base
    
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  
  default_url_options[:host] = "10.0.1.10:3000"
    
  def with_layout(email, subscriber)
    @email           = email
    @subscriber      = subscriber
    @email_subject   = @email.render(:subject, @subscriber)
    @text            = @email.render(:body,    @subscriber)
    @base_url        = "http://10.0.1.10:3000" ##{Spree::Config[:site_url]}
    @link_to_browser = read_email_url(@subscriber.token, @email.token)
    
    unless @email.nil? || @email_subject.empty? || @text.empty?
      mail(:to => @subscriber.email, :from => @email.from, :subject => @email_subject) do |format|
        format.text { render :text   => @text }
        format.html { render :layout => 'email', :text => simple_format(@text) }
      end
    end
  end
    
end