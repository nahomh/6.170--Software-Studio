require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    @myroom = rooms(:one)
    @user = users(:one)
    @user2 = users(:two)
  end

  #testing rooms controller show method 
  test "should get all page " do
    session[:user_id] = @user.id
    get :show, :id => @myroom.id
    assert_response :success
  end

  test "should_checkout" do
    session[:user_id] = @user.id
    get :checkout, :room_id => @myroom.id
    assert Room.find(@myroom.id).occupied
  end

end
