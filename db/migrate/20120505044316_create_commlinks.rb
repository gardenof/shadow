class CreateCommlinks < ActiveRecord::Migration
  def up
    create_table :commlinks do |t|
      t.integer :character_id
      t.string  :model_name
      t.string  :operating_system
      t.boolean :active
    end

    remove_column :characters, :commlink_status
  end

  def down
    drop_table :commlinks
    add_column :characters, :commlink_status, :boolean

  end
end
