Shadow::Application.routes.draw do
  root :to => 'characters#index'

  match "/game_expenses/new/:id" => "game_expenses#new", :as => :new_game_expense_with_id,:via => :get
  match "/game_assets/new/:id" => "game_assets#new", :as => :new_game_asset_with_id ,:via => :get
  resources :characters
  resources :commlinks
  resources :game_assets
  resources :game_expenses

  resources :game_settings do
    get :gmview
  end

end
