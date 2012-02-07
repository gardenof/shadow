require 'spec_helper'

describe Character do
	# If you change the params here you will have to change the test
	let (:new_character) { Character.create(name: "EE") }
	let (:new_equipped_public_asset) {GameAsset.create(equipped: true, legality: "Public",name: "1", price: 500, character: new_character, amount: 500)	}
	let (:new_equipped_restricted_asset) {GameAsset.create(equipped: true, legality: "Restricted",name: "2", price: 500, character: new_character, amount: 500)}
	let (:new_equipped_forbidden_asset) {GameAsset.create(equipped: true, legality: "Forbidden",name: "3", price: 500, character: new_character, amount: 500)	}
	let (:new_unequipped_public_asset) {GameAsset.create(equipped: false, legality: "Public",name: "1", price: 500, character: new_character, amount: 500)	}
	let (:new_unequipped_restricted_asset) {GameAsset.create(equipped: false, legality: "Restricted",name: "2", price: 500, character: new_character, amount: 500)}
	let (:new_unequipped_forbidden_asset) {GameAsset.create(equipped: false, legality: "Forbidden",name: "3", price: 500, character: new_character, amount: 500)	}


	describe "checking legality status method" do

		it "should only check equipped assets when equipped asset is on top" do
			new_equipped_public_asset
			new_unequipped_forbidden_asset

			new_character.check_legality_status.should == "Public"
		end

		it "should only check equipped assets when equipped is asset is at bottom" do
			new_unequipped_forbidden_asset
			new_equipped_public_asset

			new_character.check_legality_status.should == "Public"
		end
	
		it "should see that character status is Forbidden" do
			new_equipped_public_asset
			new_unequipped_public_asset
		 	new_equipped_restricted_asset
		 	new_unequipped_restricted_asset
		 	new_equipped_forbidden_asset
		 	new_unequipped_forbidden_asset
		 	new_equipped_public_asset

    	new_character.check_legality_status.should == "Forbidden"
		end

		it "should see that character status is Restricted" do	
			new_equipped_public_asset
			new_unequipped_public_asset
		 	new_equipped_restricted_asset
		 	new_unequipped_forbidden_asset
		 	new_equipped_public_asset

		 	new_character.check_legality_status.should == "Restricted"
		end

		it "should see that character status is Public" do
			new_equipped_public_asset
			new_unequipped_restricted_asset
			new_equipped_public_asset

		 	new_character.check_legality_status.should == "Public"
		end
	end

	describe " cheking sum_a method " do

		it "should add all the assets up" do
			new_equipped_public_asset
			new_equipped_restricted_asset
			new_equipped_forbidden_asset
			new_unequipped_public_asset
			new_unequipped_restricted_asset
			new_unequipped_forbidden_asset

			new_character.sum_a.should == 1500000
		end

		it "should add all the expenses up" do
			GameExpense.create(name: "Rent2", price: 500, character: new_character)
			GameExpense.create(name: "Rent", price: 500, character: new_character )
			
			new_character.sum_e.should == 1000
		end

	end
end