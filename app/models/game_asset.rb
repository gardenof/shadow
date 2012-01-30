class GameAsset < ActiveRecord::Base
	belongs_to :character
	  validates :name,:price,:amount,:legality, :presence => true

	def self.total 
		total = 0
     one = GameAsset.all
		one.each do |a|
			  total = a.price + total
		end
	total
	end

end
