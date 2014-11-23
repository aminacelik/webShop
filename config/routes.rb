Rails.application.routes.draw do

  scope '(:locale)' do

    get 'products/on_sale'
    get 'products/detailed_show'

    post 'orders/ship_order'
    get  'orders/purchase_confirmation'
    get  'orders/purchase_history'
    post 'orders/create_order'

    post 'addresses/select_address'
    get  'addresses/user_addresses'
    get  'addresses/new_billing_address'
    

    post 'payment/do_payment'
    get  'payment/confirmation'


    get 'session/create'
    get 'session/destroy'
  
    get 'store/index'

    resources :orders
    
    resources :addresses
    
    resources :carts
    
    resources :users
    
    resources :products do
      resources :product_images
      resources :product_variants
    end
    
    resources :categories

    resources :category_translations

    resources :product_translations

    resources :languages

    resources :sizes

    resources :colors

    resources :cities

    resources :countries

    resources :roles

    resources :line_items

    controller :session do
     get 'login' => :new
     post 'login' => :create
     delete 'login' => :destroy
    end
    
    root 'store#index', as: 'store', via: :all
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
