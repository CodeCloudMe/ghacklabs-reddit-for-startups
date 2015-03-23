BlocReddit::Application.routes.draw do

  resources :posts, only: [:index]
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      get '/up-vote' => 'votes#up_vote', as: :up_vote
      get '/down-vote' => 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end

  devise_for :users
  resources :users, only: [:show, :index, :update]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
