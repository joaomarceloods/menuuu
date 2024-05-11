Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  root controller: "private/menus", action: :index

  namespace :private do
    resource :business, only: %i[ new create update ]
    resources :menus, only: %i[ index new show create update destroy ]
    resources :menu_sections, only: %i[ create update destroy ]
    resources :menu_items, only: %i[ create update destroy ]

    resource :stripe_checkout_session, only: %i[ show ], path: :upgrade
    resource :stripe_checkout_success, only: %i[ show ], path: :upgrade_success
    resource :stripe_checkout_cancel, only: %i[ show ], path: :upgrade_cancel
    resource :stripe_portal_session, only: %i[ show ], path: :billing
  end

  namespace :public, path: nil do
    resources :businesses, only: %i[ show ], path: :b
    resources :menus, only: %i[ show ]
    resources :qrcodes, only: %i[ show ], param: :url
  end

  namespace :stripe do
    resource :webhook, only: %i[ create ], defaults: { format: :json }
  end
end
