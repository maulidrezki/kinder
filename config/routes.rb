Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects do
    resources :messages, only: [:index, :create]
    resources :volunteerings, only: [:create]
    resources :favourites, only: [:create]
    delete 'favourites', to: 'favourites#destroy'
  end

  resources :volunteerings, only: [:update, :edit, :show, :destroy]

  get "dashboard", to: "pages#dashboard", as: "dashboard"
  get "profile", to: "pages#profile", as: "profile"
  get '/users/:id', to: 'users#show', as: "users"
  get "inbox", to: "pages#inbox", as: "inbox"
  get 'about', to: 'projects#about'
end
