Todo::Application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users do 
        resources :lists, except: [:index]
      end

      resources :lists do
        resources :items, only: [:create]
      end

      resources :items, only: [:destroy]
    end
  end

  resources :users do 
    resources :lists, except: [:index]
  end

  resources :lists do
    resources :items, only: [:create, :new]
  end

  resources :items, only: [:destroy]

  root to: 'users#new'
end
