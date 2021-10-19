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
  get '/loto/draws', to: 'games#draws', as: :draws
  get '/loto/draws/new', to: 'games#new_draw', as: :new_draw
  post '/loto/draws/create', to: 'games#create_draw', as: :add_draw

  # Draw Types
  get '/loto/draw_types', to: 'games#draw_types', as: :draw_types
  get '/loto/draw_types/new', to: 'games#new_draw_type', as: :new_draw_type
  get '/loto/draw_type/:id', to: 'games#show_draw_type', as: :draw_type
  match '/loto/draw_type', to: 'games#update_draw_type', via: [:post, :patch], as: :update_draw_type
  post '/loto/draw_types/create', to: 'games#create_draw_type', as: :add_draw_type
  get '/loto/draws/results', to: 'games#draws_results', as: :draws_results
  get '/loto/draw/result', to: 'games#draw_result', as: :draw_result
  match '/loto/draw/result', to: 'games#set_draw_result', via: [:post, :patch], as: :set_draw_result
  # Bets
  get '/loto/transactions/:model_name', to: 'loto#transactions', as: :loto_transactions
  get '/loto/show/:model_name/:id', to: 'loto#show_transaction', as: :show_loto_transaction
  
  # API
  get '/api/datatables', to: 'datatables#index'
  get '/api/day-draw-types', to: 'datatables#day_draw_types'
end
