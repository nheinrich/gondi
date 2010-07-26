Gondi::Application.routes.draw do |map|

  devise_for :admins
  devise_for :users

  # facebook

  # called after login
  # match 'facebook/sign_in' => 'facebook#sign_in', :as => 'fb_connect'
  # checks fb status before sign out
  # match 'facebook/sign_out' => 'facebook#sign_out', :as => 'sign_out'

  # athletes
  resources :athletes

  # favorites
  match 'favorite/:id' => 'favorites#toggle', :as => 'favorite'
  match 'saves' => 'favorites#index', :as => 'favorites'

  # videos
  match 'watch/:id' => 'videos#show', :as => 'watch_video'
  match 'videos/add_athlete' => 'videos#add_athlete'
  match 'submit_link' => 'videos#submit_link', :as => 'submit_link'
  resources :videos

  # static
  root :to => 'welcome#index'
  match '/', :to => 'welcome#index', :as => 'admin_root'
  match 'info' => 'welcome#info', :as => 'info'

  # documentation

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
