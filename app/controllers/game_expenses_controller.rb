class GameExpensesController < ApplicationController
  include BilgePump::Controller

  model_class GameExpense

  def new
    @character = Character.find(params[:id])
    @game_expense = GameExpense.new

    respond_to do |format|
      format.html 
      format.json { render json: @game_expense }
    end
  end

  def destroy
    @game_expense = GameExpense.find(params[:id])
    @character = Character.find(@game_expense.character_id)
    @game_expense.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@character) }
      format.json { head :ok }
    end
  end
end
