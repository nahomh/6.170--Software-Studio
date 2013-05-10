require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do 

		@myuser = users(:one)

end

  test "should get show" do
    get :show, :id => @myuser.id
    assert_response :success
  end
end
