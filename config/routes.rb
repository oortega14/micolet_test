Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'users#new'
  resources :users
  resources :questions
  resources :answers do
    collection do 
      get :next
    end
  end

  resources :surveys do
    collection do
      get :confirmation
    end
  end
end
