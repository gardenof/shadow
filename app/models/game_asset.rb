class GameAsset < ActiveRecord::Base
	belongs_to :character
	  validates :name,:price,:amount,:legality, :presence => true

	def self.total 
		total = 0
		one = GameAsset.all
			one.each do |a|
				if a.price.nil? || a.amount.nil?

				else
			 	 total = (a.price*a.amount) + total
				end
			end
	total
	end

end
