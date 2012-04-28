#= require rendering
#
MoneyHelpers =
  to_yen: (amount) ->
    accounting.formatMoney amount, "¥", 0

Rendering.helpers.money = MoneyHelpers
