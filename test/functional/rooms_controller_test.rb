require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    @myroom = rooms(:one)
    @user = users(:one)
  end

  #testing rooms controller show method 
  test "should get all page " do
    session[:user_id] = @user.id
    get :show, :id => @myroom.id
    assert_response :success
  end
 
  #Testing Checkout..might need a fix
   # test "should checkout room" do
   #   get :checkout, id:@room
   #   assert_difference(@room.occupied)
   # end
 
end
