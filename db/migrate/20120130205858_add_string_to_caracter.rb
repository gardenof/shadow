class AddStringToCaracter < ActiveRecord::Migration
 def up
  	add_column :characters, :perception, :string
  	add_column :characters, :surprise, :string
  end

  def down
  	remove_column :characters, :perception
  	remove_column :characters, :surprise
  end
end