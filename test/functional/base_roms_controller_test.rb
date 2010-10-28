require 'test_helper'

class BaseRomsControllerTest < ActionController::TestCase
  setup do
    @base_rom = base_roms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_roms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_rom" do
    assert_difference('BaseRom.count') do
      post :create, :base_rom => @base_rom.attributes
    end

    assert_redirected_to base_rom_path(assigns(:base_rom))
  end

  test "should show base_rom" do
    get :show, :id => @base_rom.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @base_rom.to_param
    assert_response :success
  end

  test "should update base_rom" do
    put :update, :id => @base_rom.to_param, :base_rom => @base_rom.attributes
    assert_redirected_to base_rom_path(assigns(:base_rom))
  end

  test "should destroy base_rom" do
    assert_difference('BaseRom.count', -1) do
      delete :destroy, :id => @base_rom.to_param
    end

    assert_redirected_to base_roms_path
  end
end
