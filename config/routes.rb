Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :flags

  resources :survivors do
    member do
      put 'update-location'
    end
  end

  resources :trades
end
