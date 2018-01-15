require 'test_helper'

class StopPointsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stop_points_index_url
    assert_response :success
  end

  test "should get show" do
    get stop_points_show_url
    assert_response :success
  end

  test "should get create" do
    get stop_points_create_url
    assert_response :success
  end

end
