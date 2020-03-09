Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: "pages#home"

  get "pages/about",to: "pages#about"

  get "pages/contact",to: "pages#contact"

  resources :diaries

  get '/signup',to: "users#new"
  resources :users, except: [:new]
end
