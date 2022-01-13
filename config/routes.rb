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
  
  # Notebooks
  get '/contravention/carnets', to: 'notebooks#index', as: :notebooks
  post '/contravention/carnets', to: 'notebooks#create', as: :create_notebooks
  get '/contravention/carnet/new', to: 'notebooks#new', as: :new_notebook
  get '/contravention/carnets/:id', to: 'notebooks#edit', as: :edit_notebooks
  patch '/contravention/carnet/:id', to: 'notebooks#update', as: :update_notebook
  resources :notebooks, only: [:destroy]
  

  # Groups
  get '/contravention/classes', to: 'groups#index', as: :groups
  post '/contravention/classes', to: 'groups#create', as: :create_groups
  get '/contravention/classe/new', to: 'groups#new', as: :new_group
  get '/contravention/classes/:id', to: 'groups#edit', as: :edit_groups
  patch '/contravention/classe/:id', to: 'groups#update', as: :update_group
  resources :groups, only: [:destroy]

  #Types

  get '/contravention/types', to: 'types#index', as: :types
  post '/contravention/types', to: 'types#create', as: :create_types
  get '/contravention/type/new', to: 'types#new', as: :new_type
  get '/contravention/types/:id', to: 'types#edit', as: :edit_types
  patch '/contravention/type/:id', to: 'types#update', as: :update_type
  resources :types, only: [:destroy] 

  # Agents
  resources :agents, except: [:show]


  # Games 
  #resources :games
  #get '/loto/draws', to: 'games#draws', as: :draws
  #get '/loto/draws/new', to: 'games#new_draw', as: :new_draw
  #post '/loto/draws/create', to: 'games#create_draw', as: :add_draw

  # Draw Types
  #get '/loto/draw_types', to: 'games#draw_types', as: :draw_types
  #get '/loto/draw_types/new', to: 'games#new_draw_type', as: :new_draw_type
  #get '/loto/draw_type/:id', to: 'games#show_draw_type', as: :draw_type
  #match '/loto/draw_type', to: 'games#update_draw_type', via: [:post, :patch], as: :update_draw_type
  #post '/loto/draw_types/create', to: 'games#create_draw_type', as: :add_draw_type
  #get '/loto/draws/results', to: 'games#draws_results', as: :draws_results
  #get '/loto/draw/result', to: 'games#draw_result', as: :draw_result
  #match '/loto/draw/result', to: 'games#set_draw_result', via: [:post, :patch], as: :set_draw_result

  # Bets
  #get '/loto/transactions/:model_name', to: 'loto#transactions', as: :loto_transactions
  #get '/loto/show/:model_name/:id', to: 'loto#show_transaction', as: :show_loto_transaction
  #get '/loto/reports', to: 'loto#reports', as: :reports
  
  # API
  #get '/api/datatables', to: 'datatables#index'
  #get '/api/day-draw-types', to: 'datatables#day_draw_types'
  #get '/api/draws', to: 'datatables#draws'
  #match '/api/reports', to: 'datatables#reports', via: [:get, :post]
  #match '/api/dataset/export', to: 'datatables#export_data', via: [:get, :post]
end
