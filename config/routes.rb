Rails.application.routes.draw do
  devise_for :users

  root controller: :menus, action: :index

  resources :menus
  resources :menu_items, only: %i[ create update destroy ]
end
