require 'test_helper'

class GameExpensesControllerTest < ActionController::TestCase
  setup do
    @game_expense = game_expenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_expenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_expense" do
    assert_difference('GameExpense.count') do
      post :create, game_expense: @game_expense.attributes
    end

    assert_redirected_to game_expense_path(assigns(:game_expense))
  end

  test "should show game_expense" do
    get :show, id: @game_expense.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_expense.to_param
    assert_response :success
  end

  test "should update game_expense" do
    put :update, id: @game_expense.to_param, game_expense: @game_expense.attributes
    assert_redirected_to game_expense_path(assigns(:game_expense))
  end

  test "should destroy game_expense" do
    assert_difference('GameExpense.count', -1) do
      delete :destroy, id: @game_expense.to_param
    end

    assert_redirected_to game_expenses_path
  end
end
