Shadow::Application.routes.draw do
  root :to => 'characters#index'

  resources :characters do
      resources :game_expenses, controller: "characters/game_expenses"
      resources :game_assets, controller: "characters/game_assets"
  end

  match 'gmview' => 'characters#gmview'

end
