require 'test_helper'

class SubscribersTest < ActiveSupport::IntegrationCase
  
  def setup
    # nada!
  end
  
  should "have a link to new subscriber" do
    visit root_path
    assert has_link?("Sign up for our newsletter", :href => new_subscriber_path)
  end

  should "forward from index" do
    visit "/subscribers"
    assert_equal new_subscriber_path, current_path
  end

  should "get new subscriber" do
    visit new_subscriber_path
    assert has_content?(I18n.t('newsletter_text_signup'))
    within "#new_subscriber" do
      assert has_field?("Name")
      assert has_field?("Email")
    end
  end
  
  should "validate subscriber" do
    visit new_subscriber_path
    fill_in "Name", :with => "Someone"
    fill_in "Email", :with => "invalid"
    click_button I18n.t('sign_up')
    assert_flash(:error, I18n.t('subscribe_failed'))
    within "#new_subscriber" do
      assert has_field?("Name", :with => "Someone")
      assert has_field?("Email", :with => "invalid")
    end
  end
  
  should "create subscriber" do
    visit new_subscriber_path
    fill_in "Name", :with => "Sample McTesterman"
    fill_in "Email", :with => random_email
    click_button I18n.t('sign_up')
    assert_flash(:notice, I18n.t('subscribe_success'))
  end
  
  context "an existing subscriber" do
    
    setup do
      @subscriber = Subscriber.create(:name => "Clicky VonHackaton", :email => random_email)
    end
    
    should "fail to unsubscribe" do
      visit subscriber_path(@subscriber)
      assert has_content?(I18n.t('unsubscribe_title'))      
      assert has_content?(I18n.t('unsubscribe_mail'))
      within "#edit_subscriber_#{@subscriber.id}" do
        assert has_field?("Email")
      end
      fill_in "Email", :with => random_email
      click_button I18n.t('unsubscribe')
      assert_flash(:error, I18n.t('unsubscribe_failed_public'))
    end
    
    should "succeed to unsubscribe" do
      visit subscriber_path(@subscriber)      
      assert has_content?(I18n.t('unsubscribe_title'))      
      fill_in "Email", :with => @subscriber.email
      click_button I18n.t('unsubscribe')
      assert_flash(:error, I18n.t('unsubscribe_success_public'))
    end
        
    should "not be able to re-unsubscribe" do
      # unsubscriber..
      @subscriber.unsubscribe!
      visit subscriber_path(@subscriber) 
      # should redirect to new subscriber
      assert has_content?(I18n.t('newsletter_text_signup'))
      assert_equal new_subscriber_path, current_path
    end
    
  end
  
end