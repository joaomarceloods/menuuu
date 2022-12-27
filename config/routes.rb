Rails.application.routes.draw do
  devise_for :users

  root controller: "business/menus", action: :index

  namespace :business do
    resources :menus
    resources :menu_items, only: %i[ create update destroy ]
  end

  namespace :public, path: nil do
    resources :menus, only: %i[ show ]
  end
end
