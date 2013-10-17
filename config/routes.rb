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

  resources :users, only: [:new, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
