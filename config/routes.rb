Rails.application.routes.draw do
  root to: 'categories#index'
  resources :categories
  resources :games do
    get 'search', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
