EdgarBlogs::Application.routes.draw do
  root 'home#index'

  get 'home/index'
  get 'home/about'

  resources :articles do
    collection do
      get 'trash', to: 'articles#trash'
      delete 'trashed', to: 'articles#empty_trash'
    end
  end

  resources :users, only: [:create]

  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'
end
