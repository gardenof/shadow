class NameChageOfUserToPlayer < ActiveRecord::Migration
  def up
  	rename_column(GameAsset, "user_id", "player_id")
  end

  def down
  	rename_column(GameAsset, "player_id", "user_id")
  end
end
