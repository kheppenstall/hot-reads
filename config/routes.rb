Rails.application.routes.draw do
  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create]

      namespace :links do
        get '/status_by_url', to: 'status_by_url#get'
      end
    end
  end
end
