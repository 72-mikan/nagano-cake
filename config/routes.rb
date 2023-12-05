Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  get '/admin' => 'admin/homes#top'
  namespace :admin do
    resources :customers, only: [:index]
    resources :genres, except: [:new, :destroy]
    resources :items, except: [:destroy]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end
  
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customer/registrations",
    sessions: "customer/sessions"
  }
  
  root to: 'customer/homes#top'
  
  get '/customers/my_page' => 'customer/customers#show', as: :my_page
  get '/customers/information/edit' => 'customer/customers#edit', as: :my_information_edit
  patch '/customers/information' => 'customer/customers#update', as: :my_information
  get '/customers/information' => 'customer/customers#edit'
  get '/customers/unsubscribe' => 'customer/customers#unsubscribe', as: :unsubscribe
  patch 'customer/withdraw' => 'customer/customers#withdraw', as: :withdraw
  
  
  namespace :customer do
    resources :items, only: [:index, :show]
    resources :cart_items, except: [:new, :show, :edit]
    resources :addresses, except: [:new, :show]
    
    resources :orders, except: [:edit, :update, :destroy]
    post '/order/confirm' => 'orders#confirm'
    get '/order/complete' => 'orders#complete'
  end
  
  delete '/customer/cart_items' => 'customer/cart_items#destroy_all', as: :customer_cart_item_destroy
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
