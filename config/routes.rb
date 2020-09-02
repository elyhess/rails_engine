Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :items, except: [:new, :edit] do
        get '/merchant', to: 'items/merchant#index'#double check
      end
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchants/items#index' #double check 
      end
    end
  end
end
