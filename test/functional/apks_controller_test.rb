require 'test_helper'

class ApksControllerTest < ActionController::TestCase
  setup do
    @apk = apks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apk" do
    assert_difference('Apk.count') do
      post :create, :apk => @apk.attributes
    end

    assert_redirected_to apk_path(assigns(:apk))
  end

  test "should show apk" do
    get :show, :id => @apk.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @apk.to_param
    assert_response :success
  end

  test "should update apk" do
    put :update, :id => @apk.to_param, :apk => @apk.attributes
    assert_redirected_to apk_path(assigns(:apk))
  end

  test "should destroy apk" do
    assert_difference('Apk.count', -1) do
      delete :destroy, :id => @apk.to_param
    end

    assert_redirected_to apks_path
  end
end
