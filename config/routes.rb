Rails.application.routes.draw do
  authenticated do
    root 'memos#index', as: :authenticated_root
  end
  root 'welcome#index'
  get 'terms', to: 'welcome#terms'
  get 'privacy', to: 'welcome#privacy'
  namespace :memos do
    resources :searches, only: :index
  end
  resources :memos
  devise_for :users
  namespace :api do
    namespace :tags do
      resources :searches, only: :index
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
