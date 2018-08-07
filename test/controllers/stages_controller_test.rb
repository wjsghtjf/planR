require 'test_helper'

class StagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get stages_show_url
    assert_response :success
  end

  test "should get edit" do
    get stages_edit_url
    assert_response :success
  end

end
