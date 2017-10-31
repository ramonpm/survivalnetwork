Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  defaults format: :json do
    resources :photos

    resources :flags

    resources :survivors do
      member do
        put 'update-location'
      end
    end

    resources :trades

    get 'reports/infections', to: 'reports#infections'
    get 'reports/resource-per-survivor', to: 'reports#resource_per_survivor'
    get 'reports/lost-points', to: 'reports#lost_points'
  end
end
