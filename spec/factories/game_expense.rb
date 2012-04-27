Factory.define :game_expense do |f|
  f.name         "Rent (High)"
  f.price        500
  f.association  :character, factory: :character
  f.pay_cycle    true
end