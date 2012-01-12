class ChangeNameOfPlayerToCharactor < ActiveRecord::Migration
   def up
  	rename_column(GameAsset, "player_id", "character_id")
  end

  def down
  	rename_column(GameAsset, "character_id", "player_id")
  end
end
