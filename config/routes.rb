Rails.application.routes.draw do
  devise_for :users

  root controller: "private/businesses", action: :create

  namespace :private do
    resource :business, only: %i[ new create update ]
    resources :menus, only: %i[ index new show create update ]
    resources :menu_sections, only: %i[ create update destroy ]
    resources :menu_items, only: %i[ create update destroy ]
  end

  namespace :public, path: nil do
    resources :businesses, only: %i[ show ], path: :b
    resources :menus, only: %i[ show ]
    resources :qrcodes, only: %i[ show ], param: :url
  end
end
