class Character < ActiveRecord::Base
		has_many :game_assets
		has_many :game_expenses

	def sum_a 
		total = 0
		player = Character.find(self.id)
		player.game_assets.each do |a|
			  total = a.price + total
		end
	total
	end		
	def sum_e
		total = 0
		player = Character.find(self.id)
		player.game_expenses.each do |a|
			  total = a.price + total
		end
	total
	end		
end