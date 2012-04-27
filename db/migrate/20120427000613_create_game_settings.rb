class CreateGameSettings < ActiveRecord::Migration
  def up
    create_table :game_settings do |t|
      t.string  :name
      t.string  :in_world_geography
    end

    change_table :characters do |t|
      t.integer :game_setting_id
    end

  end

  def down
    drop_table :game_settings
    remove_column :characters, :game_setting_id
  end
end
