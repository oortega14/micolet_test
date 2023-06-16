Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'users#new'
  resources :users
  post '/survey_questions', to: 'survey_questions#create', as: 'survey_questions'
  resources :surveys do
    collection do
      get :confirmation
      get '/question/:uuid/next', to: 'surveys#next_question'
      get "question/:question_id", to: "surveys#question", as: "question"
    end
  end
end
