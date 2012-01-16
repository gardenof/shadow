class ChangeNameOfindexToCharactor < ActiveRecord::Migration
 def up
  	rename_column(GameExpense, "user_id", "character_id")
  end

  def down
  	rename_column(GameExpense, "character_id", "user_id")
  end
end
