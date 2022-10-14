Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:index, :create]
      patch 'transactions', to: 'transactions#update'
    end
  end
end
