Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'public/home#index', as: :home, defaults: { locale: :en }
  get ':locale' => 'public/home#index', constraints: { locale: Regexp.new(I18n.available_locales.join('|')) }
  get 'help' => 'public/help#index', as: :help

  namespace :private do
    resource :business, only: %i[ new create update ]
    resources :menus, only: %i[ index new show create update destroy ]
    resources :menu_sections, only: %i[ create update destroy ]
    resources :menu_items, only: %i[ create update destroy ]

    resource :stripe_checkout_session, only: %i[ show ]
    resource :stripe_checkout_success, only: %i[ show ]
    resource :stripe_checkout_cancel, only: %i[ show ]
    resource :stripe_portal_session, only: %i[ show ]
  end

  namespace :public, path: nil do
    resources :businesses, only: %i[ show ], path: :b
    resources :menus, only: %i[ show ], path: :menu
    resources :qrcodes, only: %i[ show ], path: :qr, param: :url, url: /.*/

    if Rails.env.development?
      resource :ads, except: :all do
        get :video
        get :bigphone
        get :bigred
      end
    end
  end

  namespace :stripe do
    resource :webhook, only: %i[ create ], defaults: { format: :json }
  end
end
