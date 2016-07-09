Rails.application.routes.draw do
  resources :blocks
  resources :pages
  resources :users
  resources :websites
  resources :accounts

  root "websites#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "*id" => "pages#show"
end
