Rails.application.routes.draw do
  root controller: :menus, action: :index
  resources :menus
  resources :menu_items, only: %i[ create update destroy ]
end
