Rails.application.routes.draw do

  #namespace :users do
  #get 'omniauth_callbacks/facebook'
  #end

  #namespace :users do
  #get 'omniauth_callbacks/vkontakte'
  #end

  devise_for :users, path_names: {sign_in:"login", sign_out:"logout"},
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks",
                                       :sessions => 'sessions',
                                       :registrations => 'registrations'}

  get 'static_pages/help'
  resources :lists do
    member do
      get 'sort_time_desc'
      get 'sort_time_asc'
      get 'sort_comts_desc'
      get 'sort_comts_asc'
      get 'sort_rating_desc'
      get 'sort_rating_asc'
      get 'plugin'
      get 'new_item'
    end
    member do
        get 'iframe'
      end
    resources :items do
      member do
        get 'item_comments'
      end
      resources :votes do
        post 'like', on: :member
      end
    end
    resources :comments
  end




  resources :plugin, :only => [:index, :show] do
  collection do
    get 'list_comments'
    get 'item_comments'
    end
  end




  root 'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  get 'users/:id',    to: 'users#show',    as: 'user'
  get 'users',    to: 'users#index',    as: 'users'


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
