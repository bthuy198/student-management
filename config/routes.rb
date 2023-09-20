# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  # root 'manager/students#index'
  get 'users', to: 'users#index'
  get 'admins', to: 'admins#index'

  namespace :manager do
    devise_for :users
    resources :students do
      resources :grades
      member do
        get :preview
        put :restore
        delete :really_delete
      end
      collection do
        get :search
        get :destroyed
      end
    end
  end
end
