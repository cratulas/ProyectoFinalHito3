Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "home#indexVisit"
  
  resources :products

  resource :cart, only: [:show, :update] do
    member do
      post :pay_with_paypal
      get :process_paypal_payment
    end
  end


  get 'home/indexVisit'
  get 'home/indexUser'
  get 'home/market'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  devise_for :veterinaries, controllers: {
    sessions: 'veterinaries/sessions',
    passwords: 'veterinaries/passwords',
    registrations: 'veterinaries/registrations'
  }

  # authenticate :admin do
  #   resources :products
  #   resources :categories
  # end
end
