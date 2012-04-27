Factory.define :game_asset do |f|
  f.name         "Gun"
  f.price        500
  f.amount       2
  f.equipped     true
  f.legality     "Public"
  f.association  :character, :factory => :character
end