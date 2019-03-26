Rails.application.routes.draw do
  root to: 'words#index'
  resources :words, only: [:index, :create]
end
