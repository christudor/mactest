Massolit::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'
  get "content/silver"
  get "content/gold"
  get "content/platinum"
  get "admin/index"

  authenticated :subscriber do
    root :to => 'static_pages#home'
  end
  root :to => 'static_pages#home'
  
  devise_for :subscribers, :controllers => { :registrations => "registrations" }

  authenticated :user do
    root :to => 'static_pages#home'
  end
  root :to => "static_pages#home"
 
 devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :courses
  resources :providers
  resources :imports
  resources :lessons
  resources :relationships, only: [:create, :destroy]
  resources :learners
  resources :teachers
  resources :subscribers do
    member do
      get :studying
    end
  end
  resources :schools
  resources :videos
  resources :transcripts
  resources :handouts
  resources :quizzes
  resources :questions
  resources :answers
  resources :scores

  devise_scope :user do 
    root to: 'static_pages#home'
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end

  devise_scope :subscriber do
    root to: 'static_pages#home'
    match '/sessions/subscriber', to: 'devise/sessions#create', via: :post
  end

  # The following lines match actions from weirdly-named controllers to simpler paths.
  # Instead of /static_pages/about, for example, we have /about

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/helpus',  to: 'static_pages#helpus'
  match '/faqs',    to: 'static_pages#faqs'
  match '/studentsplash', to: 'static_pages#studentsplash'
  match '/teachersplash', to: 'static_pages#teachersplash'
  match '/addcourse', to: 'courses#addcourse'
  match '/addlecture', to: 'lessons#addlecture'
  match '/coursedash', to: 'courses#coursedash'
  match '/addtranscript', to: 'transcripts#addtranscript'
  match '/addhandout', to: 'handouts#addhandout'
  match '/check', to: 'quizzes#check'

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
