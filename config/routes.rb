FlashingDeal::Application.routes.draw do

	resources :categories, :only => :show
	resources :comments, :only => [:index, :create, :destroy]
  resources :deals do
  	collection { post :sort }
  	resources :shares
  	member do
  		get :frame
  		get :watchers
  		post :score_up
  		post :score_down
  		get :add_to_queue
  		get :make_queue
  		get :make_top_deal
  		get :make_flashback
  		get :make_remove
  	end
  end
  resources :editmarks
  resources :feedbacks, :only => [:index, :create, :destroy]
  resources :forgot_names
  resources :friends
  resources :friendships, :only => [:create, :update, :destroy]
  resources :locations, :only => :show
  resources :messages, :only => [:index, :show, :create, :update]
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :relationships, :only => [:create, :destroy]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :shares, :only => [:create, :destroy]
  resources :subcomments, :only => [:create, :destroy]
  resources :users do
  	member do
  		get :watching
  		get :friends
  	end
  end
# Deals
  root :to => 'deals#top_deals'
	match '/flashback' => 'deals#flashback', :as => :flashback
	match '/flashingdeal/:id' => 'deals#frame', :as => :frame
	match '/flashmob-deals' => 'deals#flashmob_deals', :as => :flashmob_deals
	match '/remove-watched-deals' => 'deals#remove_watched_deals', :as => :remove_watched_deals
	match '/queue' => 'deals#queue', :as => :queue
	match '/rising-deals' => 'deals#rising_deals', :as => :rising_deals
	match '/search' => 'deals#search', :as => :search
  match '/create-deals' => 'deals#create_deals', :as => :create_deals
	match '/empty-queue' => 'deals#empty_queue', :as => :empty_queue
# Messages	
	match '/read-all' => 'messages#read_all', :as => :read_all
  match '/unread-all' => 'messages#unread_all', :as => :unread_all
# Pages
  match '/about' => 'pages#about', :as => :about
  match '/investors' => 'pages#investors', :as => :investors
  match '/team' => 'pages#team', :as => :team
  match '/contact' => 'pages#contact', :as => :contact
  match '/flashmob' => 'pages#flashmob', :as => :flashmob
  match '/blog' => 'pages#blog', :as => :blog
  match '/press' => 'pages#press', :as => :press
  match '/partner' => 'pages#partner', :as => :partner
	match '/faq' => 'pages#faq', :as => :faq
  match '/support' => 'pages#support', :as => :support
  match '/terms' => 'pages#terms', :as => :terms
  match '/privacy' => 'pages#privacy', :as => :privacy
  match '/test' => 'pages#test', :as => :test
# Sessions  
  match '/login'  => 'sessions#new'
  match '/logout' => 'sessions#destroy'
# Shares  
  match '/remove-shared-deals' => 'shares#remove_shared_deals', :as => :remove_shared_deals
# Users
  match '/signup' => 'users#new'
  match '/my-account' => 'users#my_account', :as => :my_account
  match '/friend-requests' => 'users#friend_requests', :as => :friend_requests
  match '/shared-deals' => 'users#shared_deals', :as => :shared_deals
# 404
  match '*url' => 'pages#page_not_found', :as => :page_not_found
end
