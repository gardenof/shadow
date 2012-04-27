Shadow::Application.routes.draw do
  root :to => 'characters#index'

  resources :characters do
      resources :game_expenses, controller: "characters/game_expenses"
      resources :game_assets, controller: "characters/game_assets"
  end

  resources :game_settings do
    get :gmview
  end

end
