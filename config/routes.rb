Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], :controllers => { registrations: :registrations, passwords: :passwords }

  as :user do
    get '/users/edit' => 'devise/registrations#edit', as: :edit_user_registration
    patch 'user/:id' => 'registrations#update', as: :user_registration
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
  get '/dashboard', to: 'main#index', as: :dashboard
  resources :users
  resources :admin_profiles

  patch '/users/edit/status/:id', to: 'users#update_account_status', as: :update_account_status
  

end
