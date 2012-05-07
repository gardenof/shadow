Shadow::Application.routes.draw do
  root :to => 'characters#index'

  match "/game_assets/new/:id" => "game_assets#new", :as => :eden,:via => :get
  resources :characters
  resources :commlinks
  resources :game_assets
  resources :game_expenses

  resources :game_settings do
    get :gmview
  end

end
