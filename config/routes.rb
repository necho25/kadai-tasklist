Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
    member do
      get 'status'
    end
  end
end
