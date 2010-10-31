require 'test_helper'

class BaseRomPackagesControllerTest < ActionController::TestCase
  setup do
    @base_rom_package = base_rom_packages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_rom_packages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_rom_package" do
    assert_difference('BaseRomPackage.count') do
      post :create, :base_rom_package => @base_rom_package.attributes
    end

    assert_redirected_to base_rom_package_path(assigns(:base_rom_package))
  end

  test "should show base_rom_package" do
    get :show, :id => @base_rom_package.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @base_rom_package.to_param
    assert_response :success
  end

  test "should update base_rom_package" do
    put :update, :id => @base_rom_package.to_param, :base_rom_package => @base_rom_package.attributes
    assert_redirected_to base_rom_package_path(assigns(:base_rom_package))
  end

  test "should destroy base_rom_package" do
    assert_difference('BaseRomPackage.count', -1) do
      delete :destroy, :id => @base_rom_package.to_param
    end

    assert_redirected_to base_rom_packages_path
  end
end
