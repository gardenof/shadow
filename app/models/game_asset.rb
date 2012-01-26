class GameAsset < ActiveRecord::Base
	belongs_to :character

	def self.total 
		total = 0
     one = GameAsset.all
		one.each do |a|
			  total = a.price + total
		end
	total
	end

end
