Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "contacts#index"

  resources :contacts
  resources :messages do
    collection do
      get :list
    end
  end

  mount ActionCable.server => '/cable'
end
