SimpleCms::Application.routes.draw do
  root "frontpage#index"
  get 'my_frontpage' => 'frontpage#my_index', as: :my_frontpage

  resources :comments
  resources :popmeters, only: ['update', 'destroy']

  resources :subs, shallow: true do
    resources :posts
    resources :subscriptions, only: ['new', 'destroy']
  end

  resources :users
  match '/my_posts', to: 'users#my_posts', via: 'get', as: :my_posts
  match '/my_subs', to: 'users#my_subs', via: 'get', as: :my_subs
  match '/my_comments', to: 'users#my_comments', via: 'get', as: :my_comments

  # session and login/out
  resources :sessions, only: [:new, :create, :destroy]
  match '/register', to: 'users#new', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
