require 'test_helper'

class UserlistControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get toggleadmin" do
    get :toggleadmin
    assert_response :success
  end

end
