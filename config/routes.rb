# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "students#index"
  # get "students#new", action: :new, controller: 'students'
  # get "/students.:id", to: "students#show"
  # post '/students/create', to: "students#create"
  # get "/students/:id/edit", to: "students#edit"
  # patch 'students/:id', to: 'students#update'
  # delete '/student/:id', to: 'student#destroy'
  # concern :paginatable do
  #   get '(page/:page)', action: :index, on: :collection, as: ''
  # end
  # resources :students, concern: :paginatable

  namespace :manager do
    devise_for :users
    root to: '/manager/students#index'
    get '/users/sign_out', to: 'devise/sessions#destroy'
    # root 'students#index'
    get '/students', to: 'students#index'
    get '/students/new', to: 'students#new'
    get '/students/:id', to: 'students#show'
    get '/students/search', to: 'students#search'
    post '/students/create', to: 'students#create'
    get '/students/:id/edit', to: 'students#edit'
    patch 'students/:id', to: 'students#update'
    delete '/student/:id', to: 'student#destroy'
    resources :students, only: %i[show index edit update destroy new]
    # resources :grades, only: %i[show index edit update destroy new]
    resources :students do
      member do
        get :preview
      end
    end
  end
end
