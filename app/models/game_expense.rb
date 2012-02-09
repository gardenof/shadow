class GameExpense < ActiveRecord::Base
		belongs_to :character
 			validates :name,:price, :presence => true
		def self.total 
		total = 0
     one = GameExpense.all
		one.each do |a|
			if a.pay_cycle == true
				monthly = a.price/12
				total = monthly + total
			else
		 	 total = a.price + total
			end
		end
	total
	end
end
