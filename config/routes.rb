Rails.application.routes.draw do
  authenticated do
    root 'memos#index', as: :authenticated_root
  end
  root 'welcome#index'

  get 'terms', to: 'welcome#terms'
  get 'privacy', to: 'welcome#privacy'

  resources :memos do
    get 'search', on: :collection
  end
  devise_for :users
  namespace :api do
    get 'tags/search'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
