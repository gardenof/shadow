class GameExpensesController < ApplicationController
  # GET /game_expenses
  # GET /game_expenses.json
  def index
    @game_expenses = GameExpense.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_expenses }
    end
  end

  # GET /game_expenses/1
  # GET /game_expenses/1.json
  def show
    @game_expense = GameExpense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_expense }
    end
  end

  # GET /game_expenses/new
  # GET /game_expenses/new.json
  def new
    @game_expense = GameExpense.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_expense }
    end
  end

  # GET /game_expenses/1/edit
  def edit
    @game_expense = GameExpense.find(params[:id])
  end

  # POST /game_expenses
  # POST /game_expenses.json
  def create
    @game_expense = GameExpense.new(params[:game_expense])

    respond_to do |format|
      if @game_expense.save
        format.html { redirect_to characters_path , notice: 'Game expense was successfully created.' }
        format.json { render json: @game_expense, status: :created, location: @game_expense }
      else
        format.html { render action: "new" }
        format.json { render json: @game_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_expenses/1
  # PUT /game_expenses/1.json
  def update
    @game_expense = GameExpense.find(params[:id])

    respond_to do |format|
      if @game_expense.update_attributes(params[:game_expense])
        format.html { redirect_to character_path(@game_expense.character) , notice: 'Game expense was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_expenses/1
  # DELETE /game_expenses/1.json
  def destroy
    @game_expense = GameExpense.find(params[:id])
    @game_expense.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@game_expense.character) }
      format.json { head :ok }
    end
  end
end
