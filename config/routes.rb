Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  

  get '/admin' => 'admin/homes#top'
  namespace :admin do
    resources :customers, only: [:index]
    resources :genres, except: [:new, :destroy]
    resources :items, except: [:destroy]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
  end

  scope module: :public do
    root to: 'homes#top'

    get '/customers/my_page' => 'customers#show', as: :my_page
    get '/customers/information/edit' => 'customers#edit', as: :customer_information_edit
    patch '/customers/information' => 'customers#update', as: :customer_information_update
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: :customer_unsubscribe
    patch 'customer/withdraw' => 'customers#withdraw', as: :customer_withdraw

    resources :items, only: [:index, :show]
    resources :cart_items, except: [:new, :show, :edit]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: :cart_item_destroy_all

    resources :addresses, except: [:new, :show]

    resources :orders, except: [:edit, :update, :destroy]
    post '/order/confirm' => 'orders#confirm', as: :order_confirm
    get '/order/complete' => 'orders#complete', as: :order_complete
  end

end
