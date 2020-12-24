Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :home, only: [:index] do
    collection do
      post :contact
    end
  end

  get '/sap', to: 'home#index'

  root to: "home#index"
end
