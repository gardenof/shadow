
Factory.define :character do |user|
	
  user.name                  "Michael Hartl"
  user.perception            "+7"
  user.surprise              "-5"
end

Factory.define :game_asset do |user|
	
  user.name                  "Gun"
  user.price            			500
  user.amount									20
  user.equipped								true
  user.legality								"Public"
  user.association   :character, :factory => :character
end
