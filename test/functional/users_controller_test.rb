require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do 
		@myuser = users(:one)
  end

  test "should get show" do
    get :show, :id => @myuser.id
    assert_response :success
  end

  test "should update location" do
    session[:user_id] = @myuser.id
    xhr :get, :set_location, {:longitude => 25, :latitude => 30}
    assert_equal User.find(@myuser.id).longitude, 25
    assert_equal User.find(@myuser.id).latitude, 30
  end
end
