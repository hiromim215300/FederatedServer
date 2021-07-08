require 'test_helper'

class ServersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get servers_new_url
    assert_response :success
  end

end
