class Character < ActiveRecord::Base
		has_many :game_assets
		has_many :game_expenses
		validates :name, :presence => true

def self.character_legality_
	
end

	def sum_a 
		total = 0
		self.game_assets.each do |a|
			if a.price.nil?

			else
			  total = a.price + total
			end
		end
	total
	end		
	def sum_e
		total = 0
		self.game_expenses.each do |a|
			  total = a.price + total
		end
	total
	end		

	def sum
		 self.each do |c|
		 		print name
		 end
		 print total
	end

end