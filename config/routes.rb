Rails.application.routes.draw do
  devise_for :users

  root controller: "private/menus", action: :index

  namespace :private do
    resource :business, only: %i[ new create update ]
    resources :menus
    resources :menu_items, only: %i[ create update destroy ]
  end

  namespace :public, path: nil do
    resources :menus, only: %i[ show ]
  end
end
