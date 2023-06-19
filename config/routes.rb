# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'site/users#new'
  namespace :site, path: '/' do
    scope ':locale' do
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
