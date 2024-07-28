Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashbords', to: 'dashbords#index'
    resources :users, only: [:show, :destroy]
  end
  
  scope module: :public do
    devise_for :users
    root to: "homes#top"
    get 'homes/about', to: "homes#about", as: :about
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
    
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        get :favorites
        get :follows, :followers
      end
        resource :relationships, only: [:create, :destroy]
    end
    
    get "/search", to: "searches#search"
    devise_scope :user do
      post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
