LimayWaterDistrict::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  namespace :admin do
  	match 'login' => "session#new", :via => :get,	:as => "login_page"
  	match 'login' => "session#create", :via => :post,	:as => "login_user"
  	match 'logout' => "session#destroy", :via => :get,	:as => "logout_user"
  	match '/' => 'main#index', :via => :get

		match '/index' => 'main#index', :via => :get
		resources :pages
    resources :posts
    resources :users
    resources :banners
    resources :contacts
    resources :enquiries, only: [:index, :show, :destroy]
    match 'commons/update' => 'main#common_update', :via => :put, :as => 'common_update'
  end
  match '/', to: 'home#index', via: :get
  match '/home', to: 'home#index', :via => :get
  match '/contact-us', to: 'pages#contacts', via: :get, as: 'contact_us'
  match '/enquiry', to: 'pages#send_enquiry', via: :post, as: 'send_enquiry'
  match '/posts', to: 'posts#index', via: :get
  match '/posts/(:page_url)', to: 'posts#show', via: :get, as: 'show_post'
  match '/(:page_url)' => 'pages#show', via: :get, constraints: { page_url: /.*/ }, as: 'pages'
  root :to => 'home#index'

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
