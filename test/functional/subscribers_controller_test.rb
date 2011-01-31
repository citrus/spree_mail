require 'test_helper'

class SubscribersControllerTest < ActionController::TestCase
  
  should "get redirected from index" do
    get :index
    assert_response :redirect, new_subscriber_path
  end
  
  should "get new subscriber" do
    get :new
    assert_response :success
    assert_not_nil assigns(:subscriber)
  end
  
  should "create subscriber" do
    email = random_email
    post :create, :subscriber => { :name => "Subby Subscriptor", :email => email }
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
  
end