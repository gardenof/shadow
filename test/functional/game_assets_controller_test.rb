require 'test_helper'

class GameAssetsControllerTest < ActionController::TestCase
  setup do
    @game_asset = game_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_asset" do
    assert_difference('GameAsset.count') do
      post :create, game_asset: @game_asset.attributes
    end

    assert_redirected_to game_asset_path(assigns(:game_asset))
  end

  test "should show game_asset" do
    get :show, id: @game_asset.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_asset.to_param
    assert_response :success
  end

  test "should update game_asset" do
    put :update, id: @game_asset.to_param, game_asset: @game_asset.attributes
    assert_redirected_to game_asset_path(assigns(:game_asset))
  end

  test "should destroy game_asset" do
    assert_difference('GameAsset.count', -1) do
      delete :destroy, id: @game_asset.to_param
    end

    assert_redirected_to game_assets_path
  end
end
