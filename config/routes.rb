Rails.application.routes.draw do
  devise_for :users

  root 'group_events#index'
  resources :group_events
end
