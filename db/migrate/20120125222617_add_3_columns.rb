class Add3Columns < ActiveRecord::Migration
  def up
  	add_column :game_assets, :amount, :integer
  	add_column :game_assets, :equipped, :boolean
  	add_column :game_assets, :legality, :string
  end

  def down
  	remove_column :game_assets, :amount 
  	remove_column :game_assets, :equipped 
  	remove_column :game_assets, :legality

  end
end

