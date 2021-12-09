require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get indexVisit" do
    get home_indexVisit_url
    assert_response :success
  end

  test "should get indexUser" do
    get home_indexUser_url
    assert_response :success
  end

end
