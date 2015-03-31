Rails.application.routes.draw do

    root 'welcome#parallax'
    get '/parallax', to: 'welcome#parallax'
    resources :documents
    resources :users

    get '/signin', to: 'sessions#new'
    post '/signin', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'

end
