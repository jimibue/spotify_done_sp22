Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    get 'artists', to:'artists#index'
    get 'artists/:id', to:'artists#show'
    post 'artists', to:'artists#create'
    put 'artists/:id', to:'artists#update'
    delete 'artists/:id', to:'artists#destroy'

    get 'artists/:artist_id/songs', to:'songs#index'
    get 'artists/:artist_id/songs/:id', to:'songs#show'
    post 'artists/:artist_id/songs', to:'songs#create'
    put 'artists/:artist_id/songs/:id', to:'songs#update'
    delete 'artists/:artist_id/songs/:id', to:'songs#destroy'
  end
end
