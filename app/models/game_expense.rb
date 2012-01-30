class GameExpense < ActiveRecord::Base
		belongs_to :character
 			validates :name,:price, :presence => true
		def self.total 
		total = 0
     one = GameExpense.all
		one.each do |a|
			  total = a.price + total
		end
	total
	end
end
