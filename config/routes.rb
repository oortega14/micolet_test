# frozen_string_literal: true

require 'sidekiq/web'
# require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :site, path: '/' do
    scope ':locale' do
      root to: 'users#new'

      resources :users do
        member do
          post :survey
          get :confirmation
        end
      end

      resources :answers do
        collection do
          get :next
          get :end_page
        end
      end

    end
  end
end
