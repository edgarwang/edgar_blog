EdgarBlogs::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  get 'home/about'

  namespace :dashboard do
    root 'articles#index'

    resources :articles do
      collection do
        get 'trash', to: 'articles#trash'
        delete 'trashed', to: 'articles#empty_trash'
      end
      member do
        post 'trash', to: 'articles#send_to_trash', as: 'send_to_trash'
        post 'restore', to: 'articles#restore', as: 'restore'
      end
    end

    resources :attachments, only: [:new, :create, :index, :destroy]
  end

  resources :users, only: [:create]

  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'
end
