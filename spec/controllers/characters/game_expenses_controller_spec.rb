require 'spec_helper'

describe Characters::GameExpensesController do
  include BilgePump::Specs

  model_scope [:character]
  model_class GameExpense

  render_views

  def attributes_for_create
    {name: "create"}
  end

  def attributes_for_update
    {name: "update"}
  end

end