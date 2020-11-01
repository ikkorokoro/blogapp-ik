require "sidekiq/web"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "articles#index"

  resources :articles
  # resources :comments, only: [:index, :new, :create]
  #   resource :like, only: [:show, :create, :destroy]
  # end#, only: [:show, :new, :create, :edit, :update, :destroy]

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end
  

  scope module: :apps do
    resources :favorites, only: [:index]
    resource :timeline, only: [:show] #=> %i(show create)
    resource :profile, only: [:show, :edit, :update]
  end

  namespace :api, defaults: { format: :json } do #レスポンスはjsonで返して欲しいのでformatはjsonと指定する
    scope "/articles/:article_id" do
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]
    end
  end
end
