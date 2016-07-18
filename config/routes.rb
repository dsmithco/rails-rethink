Rails.application.routes.draw do
  devise_for :users
  resources :blocks
  resources :pages
  resources :attachments, controller: 'attachments', type: 'Attachment'
  resources :logos, controller: 'attachments', type: 'Logo'
  resources :icons, controller: 'attachments', type: 'Icon'
  resources :images, controller: 'attachments', type: 'Image'
  resources :hero_images, controller: 'attachments', type: 'HeroImage'
  resources :users
  resources :websites do
    resources :blocks
    resources :pages
    resources :attachments
  end
  resources :accounts

  root "websites#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "*id" => "pages#show"
end
