require 'test_helper'

class EmailsControllerTest < ActionController::TestCase
  
  def setup
    setup_email_with_subscribers
  end
  
  should "show email to recipient" do
    get :show, :subscriber => @subscriber1.token, :email => @email.token
    assert_response :success
    assert_not_nil assigns(:subscriber)
    assert_not_nil assigns(:email)
    assert_not_nil assigns(:email_subject)
    assert_not_nil assigns(:text)
    assert_not_nil assigns(:base_url)
  end
  
  should "redirect if subscriber is not an intended recipient" do
    @subscriber3 = Subscriber.create(:name => "Hacker McHackety", :email => random_email)
    get :show, :subscriber => @subscriber3.token, :email => @email.token
    assert_response :redirect, new_subscriber_path
    assert !flash.empty?
  end
  
  
  should "error on show without tokens" do
    assert_raise ActionController::RoutingError do
      get :show
    end
  end
  
  should "error on index" do
    assert_raise ActionController::RoutingError do
      get :index
    end
  end
  
  should "error on new" do
    assert_raise ActionController::RoutingError do  
      get :new
    end
  end
  
  should "error on create" do
    assert_raise ActionController::RoutingError do  
      get :new
    end
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
  
end