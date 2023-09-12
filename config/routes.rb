Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "students#index"
  get "students#new", action: :new, controller: 'students'
  get "/students.:id", to: "students#show" 
  post '/students/create', to: "students#create"
  get "/students/:id/edit", to: "students#edit"
  patch 'students/:id', to: 'students#update'
  delete '/student/:id', to: 'student#destroy'
  resources :students
  
end
