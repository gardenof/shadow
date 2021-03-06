class Character < ActiveRecord::Base
	has_many :game_assets, :dependent => :destroy
	has_many :game_expenses, :dependent => :destroy
	has_one :commlink, dependent: :destroy
	validates :name, :presence => true

	def check_legality_status
		send_back_status= ""
		game_assets.each  do |c|
			if c.equipped == true
				if    c.legality == "Forbidden"
          send_back_status= c.legality
        elsif c.legality == "Restricted" && send_back_status != "Forbidden"
          send_back_status= c.legality
        elsif send_back_status != "Restricted" && send_back_status != "Forbidden"
          send_back_status= c.legality
        end
      else
			end
		end
		send_back_status
	end

	def sum_a
		total = 0
		game_assets.each do |a|
			if a.price.nil? || a.amount.nil?

			else
			  total = (a.price*a.amount) + total
			end
		end
	total
	end

	def sum_e
		total = 0
		game_expenses.each do |a|
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