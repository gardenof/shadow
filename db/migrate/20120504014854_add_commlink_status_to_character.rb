class AddCommlinkStatusToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.boolean :commlink_status
    end
  end
end
