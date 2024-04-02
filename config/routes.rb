Rails.application.routes.draw do
  resources :posts, only: [:index, :create, :new]
  root 'homes#index'
  devise_for :users
  resources :homes, only: :index do
    collection do
      get :profile
      get :send_request_to_user
      get :add_friend
      get :my_request
      get :accepted
      get :my_friend
      get :remove_friend
      get :cancel_friend_request
    end
  end
end
