module CharactersHelper

	def color_for_legality(legality_status)
		case legality_status
			when "Forbidden" then "#FF0700"
			when "Restricted" then "#FFD500"
			else "#00C90D"
		end
	end

end
