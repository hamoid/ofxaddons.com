Rails.application.routes.draw do

  root to: redirect('/categories')

  resources :addons,       only: [:index, :show]
  resources :categories,   only: [:index, :show]
  resources :contributors, controller: 'users', only: [:index]

  get "contributors/:login",      to: "users#show",                        as: :contributor
  get "freshest",                 to: "addons#index",    sort: "freshest", as: :freshest
  get "popular",                  to: "addons#index",    sort: "popular",  as: :popular
  get "unsorted",                 to: "unsorteds#index",                   as: :unsorted

  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout",                  to: "sessions#destroy",                  as: :logout

  namespace :admin do
    resources :repos, only: [:index, :update]
  end

  # legacy JSON API
  constraints(format: 'json') do
    get "/api/v1/search", to: "apis#search1"
    get "/api/v1/users/:login", to: "apis#user1"
    get "/api/v1/users/:login/repos", to: "apis#user_repos1"
    get "/api/v1/users/:login/repos/:repo_name", to: "apis#user_repo1"
    get "/api/v1/repos", to: "apis#repos1"
    get "/api/v1/repos/:repo_name", to: "apis#repo1"
    get "/api/v1/all", to: redirect("/api/v1/repos")
  end

  #
  # redirects
  #

  get "/category",                to: redirect("/categories")
  get "/category/:id",            to: redirect("/categories")
  get "/changes",                 to: redirect("/freshest")
  get "/howto",                   to: redirect("/pages/howto")
  get "/users/:login",            to: redirect("/contributors/%{login}")


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
