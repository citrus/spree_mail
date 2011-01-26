class SubscribersControllerTest < ActionController::TestCase
  
  test "should get index" do
    get :index
    assert_response :redirect, new_subscriber_path
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
end
