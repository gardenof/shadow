class AddHistoricalsToCharacter < ActiveRecord::Migration
  def change
    change_table :characters do |t|
      t.integer :current_karma
      t.integer :lifetime_karma
      t.integer :current_cash
      t.string  :play_style
    end
  end
end
