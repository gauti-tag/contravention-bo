Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], :controllers => { registrations: :registrations, passwords: :passwords }

  as :user do
    get '/users/edit' => 'devise/registrations#edit', as: :edit_user_registration
    patch 'user/:id' => 'registrations#update', as: :user_registration
    get '/reset_password/:reset_password_token', to: 'passwords#edit'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  resources :users
  resources :admin_profiles
  resources :parameters

 
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
  resources :notebooks, only: [:destroy] do 
    collection {post :import}
  end
  

  # Groups
  get '/contravention/classes', to: 'groups#index', as: :groups
  post '/contravention/classes', to: 'groups#create', as: :create_groups
  get '/contravention/classe/new', to: 'groups#new', as: :new_group
  get '/contravention/classes/:id', to: 'groups#edit', as: :edit_groups
  patch '/contravention/classe/:id', to: 'groups#update', as: :update_group
  resources :groups, only: [:destroy] do 
    collection {post :import}
  end

  #Types

  get '/contravention/types', to: 'types#index', as: :types
  post '/contravention/types', to: 'types#create', as: :create_types
  get '/contravention/type/new', to: 'types#new', as: :new_type
  get '/contravention/types/:id', to: 'types#edit', as: :edit_types
  patch '/contravention/type/:id', to: 'types#update', as: :update_type
  post '/contravention/type/status', to: 'types#update_status'
  resources :types, only: [:destroy] do 
    collection {post :import}
  end

  # Agents
  resources :agents, except: [:show] do 
    collection {post :import}
  end
  
  # Api Datatable
  scope 'api' do 
    get 'datatables', to: 'datatables#index'
    match '/dataset/export', to: 'datatables#export_data', via: [:get, :post]
  end

  # Transactions
  scope 'transactions' do
    get 'contravention/:model', to: 'transactions#index', as: :transactions
    get 'contravention/show/:model/:id', to: 'transactions#show', as: :show_transaction
  end
end
