Rails.application.routes.draw do
  root 'memos#index'

  resources :memos do
    get 'search', on: :collection
  end
  devise_for :users
end
