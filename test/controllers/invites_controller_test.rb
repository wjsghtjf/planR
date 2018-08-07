require 'test_helper'

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get invites_create_url
    assert_response :success
  end

  test "should get update" do
    get invites_update_url
    assert_response :success
  end

end
