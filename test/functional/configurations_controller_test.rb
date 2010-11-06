require 'test_helper'

class ConfigurationsControllerTest < ActionController::TestCase
  setup do
    @configuration = configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create configuration" do
    assert_difference('Configuration.count') do
      post :create, :configuration => @configuration.attributes
    end

    assert_redirected_to configuration_path(assigns(:configuration))
  end

  test "should show configuration" do
    get :show, :id => @configuration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @configuration.to_param
    assert_response :success
  end

  test "should update configuration" do
    put :update, :id => @configuration.to_param, :configuration => @configuration.attributes
    assert_redirected_to configuration_path(assigns(:configuration))
  end

  test "should destroy configuration" do
    assert_difference('Configuration.count', -1) do
      delete :destroy, :id => @configuration.to_param
    end

    assert_redirected_to configurations_path
  end
end
