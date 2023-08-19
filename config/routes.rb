Rails.application.routes.draw do
  post 'tasks/:id/toggle', to: 'tasks#toggle'
  get 'tasks/not_completed', to: 'tasks#not_completed'
  get 'tasks/completed', to: 'tasks#completed'
  get '/tasks/not_completed_count', to: 'tasks#not_completed_count'
 
  resources :tasks do
    collection do
      delete :delete_completed
    end
  end

  root 'tasks#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
