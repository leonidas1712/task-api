Rails.application.routes.draw do
  resources :categories do
    resources :tasks, except: [:update]
  end
  
  resources :tasks, only: [:index, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
