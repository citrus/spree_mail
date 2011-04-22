require_relative '../test_helper'

class SubscribersControllerTest < ActionController::TestCase
  
  def setup
    # nada!
  end
  
  should "get new subscriber" do
    get :new
    assert_response :success
    assert_not_nil assigns(:subscriber)
  end
  
  should "validate subscriber" do
    post :create, :subscriber => { :email => "" }
    assert_response :success
    assert !flash.empty?
    assert_equal I18n.t('subscribe_failed'), flash[:error]
  end
  
  should "create subscriber" do
    email = random_email
    post :create, :subscriber => { :email => email }
    assert_not_nil Subscriber.find_by_email(email)
    assert_response :redirect, new_subscriber_path
    assert !flash.empty?
  end
  
  should "error on edit" do
    assert_raise ActionController::RoutingError do
      get :edit
    end
  end
  
  should "error on update" do
    assert_raise ActionController::RoutingError do
      put :update
    end
  end
  
  should "error on destroy" do
    assert_raise ActionController::RoutingError do
      delete :destroy
    end
  end
  
  context "an existing subscriber" do
    
    setup do
      @email = random_email
      @subscriber = Subscriber.create(:email => @email)
    end
    
    should "render show" do
      get :show, :id => @subscriber.token
      assert_response :success
      assert_not_nil assigns(:subscriber)
    end
    
    should "fail to unsubscribe" do
      put :unsubscribe, :id => @subscriber.token, :subscriber => { :email => "wrong-email@domain.com" }
      assert_not_nil assigns(:subscriber)
      assert_equal I18n.t('unsubscribe_failed_public'), flash[:error]
    end
    
    should "unsubscribe" do
      put :unsubscribe, :id => @subscriber.token, :subscriber => { :email => @email }
      assert_response :redirect, new_subscriber_path
      assert_equal I18n.t('unsubscribe_success_public'), flash[:notice]
    end
    
    should "redirect when already unsubscribed" do
      @subscriber.unsubscribe!
      get :show, :id => @subscriber.token
      assert_response :redirect, new_subscriber_path
    end
    
  end
  
end