class Character < ActiveRecord::Base
		has_many :game_assets
		has_many :game_expenses

	def sum_a (id)
		character_id=id
		total = 0
		player = Character.find(character_id)
		player.game_assets.each do |a|
			  total = a.price + total
		end
	total
	end		
	def sum_d (id)
		character_id=id
		total = 0
		player = Character.find(character_id)
		player.game_expenses.each do |a|
			  total = a.price + total
		end
	total
	end		
end
