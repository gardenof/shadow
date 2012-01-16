class GameAsset < ActiveRecord::Base
	belongs_to :character

	def sum 
		total = 0
		GameAsset.all.each do |a|
			  total = a.price + total
			end
			total
	end		

	def add_upcase(before_upcase)
    all_caps = String.new(before_upcase)
    all_caps.upcase
  end
end
