module Characters
  class GameExpensesController < ApplicationController
    include BilgePump::Controller

    model_scope [:character]
    model_class GameExpense

  end
end
