require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get profiles_show_url
    assert_response :success
  end

  test "should get my" do
    get profiles_my_url
    assert_response :success
  end
end
