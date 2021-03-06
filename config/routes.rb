Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /vi|en/ do
    root 'home#index'
    devise_for :users, controllers: {
  	  sessions: 'users/sessions',
  	  registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      unlocks: 'users/unlocks',
      passwords: 'users/passwords'
    }
    devise_scope :user do
      get "users/show", to: 'users/registrations#show'
    end
    resources :stocks
    get 'stocks/new/list', to: 'stocks#new_list'
    post 'stocks/new/list', to: 'stocks#create_list'
    resources :trades
    get 'trades/new/list', to: 'trades#new_list'
    post 'trades/new/list', to: 'trades#create_list'
  end
end
