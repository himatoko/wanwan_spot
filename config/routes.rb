Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashbords', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
  scope module: :public do
    devise_for :users
    root to: "homes#top"
    get 'homes/about', to: "homes#about", as: :about
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    get "/search", to: "searches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
