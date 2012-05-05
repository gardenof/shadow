Shadow::Application.routes.draw do
  root :to => 'characters#index'

  resources :characters do
      resources :game_expenses, controller: "characters/game_expenses"
  end

  resources :game_assets

  resources :game_settings do
    get :gmview
  end

end
