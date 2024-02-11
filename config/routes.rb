# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root to: 'home#index'
    devise_for :users, path: '', controllers: { registrations: 'users/registrations' }
    resources :categories, only: %i[index create update destroy]
    resources :events, only: %i[index show create update destroy]
    resources :archive, only: %i[index show destroy] do
      collection do
        delete 'destroy_all'
      end
    end
  end
end
