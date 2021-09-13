Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], :controllers => { registrations: :registrations, passwords: :passwords }

  as :user do
    get '/users/edit' => 'devise/registrations#edit', as: :edit_user_registration
    patch 'user/:id' => 'registrations#update', as: :user_registration
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  resources :users
  resources :admin_profiles

  get '/dashboard', to: 'main#index', as: :dashboard
  get '/piste-audit', to: 'main#audit', as: :audit
  get '/piste-audit/log/:id', to: 'main#show_log', as: :audit_log

  patch '/users/edit/status/:id', to: 'users#update_account_status', as: :update_account_status

  # Games 
  resources :games
  get '/loto/draws', to: 'games#draws', as: :games_draws
  get '/loto/draws/new', to: 'games#new_draw', as: :new_game_draw
  post '/loto/draws/create', to: 'games#create_draw', as: :add_draw

  # Bets
  get '/loto/placed_bets', to: 'loto#placed_bets', as: :placed_bets
  get '/loto/winning_bets', to: 'loto#winning_bets', as: :winning_bets
  
  get '/datatables/placed-bets', to: 'datatables#placed_bets'
  get '/datatables/winning-bets', to: 'datatables#winning_bets'
end
