Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "site/users#new"

  # Defines the root path route ("/")
  namespace :site, path: "/" do
    scope ":locale" do
      root to: 'users#new'
      resources :users do 
        member do
          patch :survey
          get :confirmation
        end
      end
      resources :questions
      resources :answers do
        collection do 
          get :next
          get :end_page
        end
      end
    end
  end
end
