Integra1::Application.routes.draw do

  post 'email' => 'emails#create'
  root :to =>'application#index'
  match 'reponer' => 'bodegas#reponer'
  get 'main_logs' => "logs#main_logs"
  get 'queue_logs' => "logs#queue_logs"
  get 'whenever_logs' => "logs#whenever_logs"
  get 'bodega_logs' => "logs#bodega_logs"

  match 'dashboard/reportes/:id/descargar_excel' => 'dashboards#descargar_excel', as: :descargar_excel, via: :get, :defaults => { :format => 'xlsx' }
  match 'dashboard/reportes' => 'dashboards#reportes_diarios', as: :reportes_diarios, via: :get

  resources :bodegas do
    collection do
      get 'consulta'
    end
  end

  resources :pedidos do
    get 'show_map'
    collection do
      get 'tiempo'
    end
  end

  match 'dashboard' => "dashboards#index"

  resources :reservas do
  
  end

  resources :transacciones do
  
  end
  
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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
