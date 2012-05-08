class GameExpensesController < ApplicationController
  include BilgePump::Controller

  model_class GameExpense

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
