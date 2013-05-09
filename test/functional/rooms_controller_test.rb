require 'test_helper'

class RoomsControllerTest < ActiveController::TestCase
 #testing rooms controller show method 
 test "should get show" do
    get :show
    assert_response :success
  end
 
 #Testing Checkout..might need a fix
  test "should checkout room" do
    get :checkout, id:@room
    assert_difference(@room.occupied)
  end
 
end
