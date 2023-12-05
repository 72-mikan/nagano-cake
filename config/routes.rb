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
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  scopr module: :public do
    root to: 'homes#top'
    get '/customers/my_page' => 'customers#show', as: :my_page
    get '/customers/information/edit' => 'customers#edit', as: :my_information_edit
    patch '/customers/information' => 'customers#update', as: :my_information
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: :unsubscribe
    patch 'customer/withdraw' => 'customers#withdraw', as: :withdraw
    
    resources :items, only: [:index, :show]
    resources :cart_items, except: [:new, :show, :edit]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: :customer_cart_item_destroy
    resources :addresses, except: [:new, :show]
    resources :orders, except: [:edit, :update, :destroy]
    post '/order/confirm' => 'orders#confirm'
    get '/order/complete' => 'orders#complete'
  end
  
end
