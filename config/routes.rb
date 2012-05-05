Shadow::Application.routes.draw do
  root :to => 'characters#index'

  resources :characters
  resources :game_assets
  resources :game_expenses

  resources :game_settings do
    get :gmview
  end

end
