Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :items, except: [:new, :edit] do
        get '/merchant', to: 'items/merchant#index'
      end
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchants/items#index'
      end
    end
  end
end
