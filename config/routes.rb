Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :blocks
  resources :pages do
    member do
      delete "delete_image/:image_id" => "pages#delete_image"
      post "add_image" => "pages#add_image"
      put "add_block/:block_id" => "pages#add_block"
      put "remove_block/:block_id" => "pages#remove_block"
    end
  end
  resources :page_blocks
  get "pages/:page_id/:id" => "pages#show"
  match "pages/:page_id/:id" => "pages#update", via: [:put, :patch]
  delete "pages/:page_id/:id" => "pages#destroy"
  post "pages/:page_id/:id" => "pages#create"
  resources :attachments, controller: 'attachments', type: 'Attachment'
  resources :logos, controller: 'logos', type: 'Logo'
  resources :icons, controller: 'attachments', type: 'Icon'
  resources :images, controller: 'images', type: 'Image'
  resources :hero_images, controller: 'hero_images', type: 'HeroImage'
  resources :users
  resources :websites do
    resources :blocks
    resources :pages
    resources :attachments
    member do
      get 'stylesheet'
    end
  end
  resources :accounts

  root "websites#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # this is to handle an old url for morerain.com
  constraints(:host => /morerain.com/) do
    match "/podcasts/mp3/morerain" => redirect {|params, req| "http://feeds.feedburner.com/morerain/#{params[:path]}"},  via: [:get]
    match "/podcasts/mp3/morerain.xml" => redirect {|params, req| "http://feeds.feedburner.com/morerain/#{params[:path]}"},  via: [:get]
  end

  get "*id" => "pages#show"
end
