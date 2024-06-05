Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users #自動追記されなかった
  resources :items do
    resources :orders, only:[:index, :create]
  end
  root "items#index"
end
