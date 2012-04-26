# encoding: utf-8
module CharactersHelper

	def color_for_legality(legality_status)
		case legality_status
			when "Forbidden" then "#FF0700"
			when "Restricted" then "#FFD500"
			else "#00C90D"
		end
	end

  def to_yen(number)
    number_to_currency(number, {
      unit: '¥',
      precision: 0
    })
  end

end
