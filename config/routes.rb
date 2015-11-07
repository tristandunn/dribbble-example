Rails.application.routes.draw do
  resources :sessions, only: [:new]

  root to: "pages#index"
end
