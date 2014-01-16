Kebapress::Engine.routes.draw do

  resources :dashboard, only: [:index]
  resources :posts
  resources :categories
  post '/posts/imageUpload', to: 'posts#image_upload'

  get '/', to: 'dashboard#index'
end
