Rails.application.routes.draw do

  resources :answers
  resources :form_responses
  resources :questions
  resources :forms
  resources :categories do
    member do
      get 'search'
    end
  end
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :blocks do
    collection do
      post :sort
    end
  end
  resources :pages do
    collection do
      post :sort
    end
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
  resources :icons, controller: 'icons', type: 'Icon'
  resources :images, controller: 'images', type: 'Image'
  resources :hero_images, controller: 'hero_images', type: 'HeroImage'
  resources :users
  resources :websites do
    resources :blocks
    resources :pages
    resources :attachments
    member do
      get 'stylesheet'
      get 'edit_heroes'
      get 'random_hero'
    end
  end
  resources :accounts

  post 'partials/add'
  post 'partials/reload'
  post 'partials/remove'

  get 'sitemap' => 'websites#sitemap', :format => "xml"
  get 'robots' => 'websites#robots', :format => 'txt'
  root "websites#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "*keyword" => "websites#home"

  # this is to handle an old url for morerain.com
  constraints(:host => /morerain.com/) do
    match "/podcasts/mp3/morerain" => redirect {|params, req| "http://feeds.feedburner.com/morerain/#{params[:path]}"},  via: [:get]
    match "/podcasts/mp3/morerain.xml" => redirect {|params, req| "http://feeds.feedburner.com/morerain/#{params[:path]}"},  via: [:get]
  end

end
