Rails.application.routes.draw do
  root controller: :menus, action: :index
  resources :menus
end
