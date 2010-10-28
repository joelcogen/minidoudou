require 'test_helper'

class OptionsControllerTest < ActionController::TestCase
  setup do
    @option = options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create option" do
    assert_difference('Option.count') do
      post :create, :option => @option.attributes
    end

    assert_redirected_to option_path(assigns(:option))
  end

  test "should show option" do
    get :show, :id => @option.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @option.to_param
    assert_response :success
  end

  test "should update option" do
    put :update, :id => @option.to_param, :option => @option.attributes
    assert_redirected_to option_path(assigns(:option))
  end

  test "should destroy option" do
    assert_difference('Option.count', -1) do
      delete :destroy, :id => @option.to_param
    end

    assert_redirected_to options_path
  end
end
