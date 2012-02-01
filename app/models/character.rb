class Character < ActiveRecord::Base
		has_many :game_assets
		has_many :game_expenses
		validates :name, :presence => true

		def character_legality_status
			send_back= ""
			game_assets.each  do |c|
				if c.equipped == true
					if    c.legality == "Forbidden"   
            @send_back_legality = c.legality 
	        elsif c.legality == "Restricted" && @color != "Forbidden"
            @send_back_legality = c.legality 
	        elsif  @color != "Forbidden" && @color != "Restricted"  
            @send_back_legality = c.legality 
	        end 
				end
			end
			@send_back_legality
		end

	def sum_a 
		total = 0
		game_assets.each do |a|
			if a.price.nil?

			else
			  total = a.price + total
			end
		end
	total
	end		
	def sum_e
		total = 0
		game_expenses.each do |a|
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