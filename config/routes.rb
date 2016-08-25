Rails.application.routes.draw do
  devise_for :users

  root 'group_events#index'
  resources :group_events do
    get :deleted, on: :collection
  end

  namespace :api, defaults: {format: :json}  do
    namespace :v1 do
      resources :group_events do
        get :deleted, on: :collection
      end
    end
  end
end
