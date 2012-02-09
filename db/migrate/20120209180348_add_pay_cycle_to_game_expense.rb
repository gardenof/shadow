class AddPayCycleToGameExpense < ActiveRecord::Migration
   def up
  	add_column :game_expenses, :pay_cycle, :boolean
  end

  def down
  	remove_column :game_expenses, :pay_cycle
 
  end
end
