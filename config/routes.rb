# frozen_string_literal: true

Rails.application.routes.draw do
  resources :schools
  devise_for :admins
  devise_for :users

  # root 'manager/students#index'
  get 'users', to: 'users#index'
  get 'admins', to: 'admins#index'
  get 'schools/search', to: 'schools#search'

  namespace :manager do
    devise_for :users
    resources :students do
      member do
        get :preview
        put :restore
        delete :really_delete
      end
      collection do
        get :destroyed
      end
    end
    resources :student_classes
    resources :teachers
  end
end
