require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "show should be exist" do
    get :show
    assert_response :success
    assert_not_nil assigns(:user)
  end
end
