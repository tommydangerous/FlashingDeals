FlashingDeal::Application.routes.draw do

	resources :categories, :only => :show
	resources :categories do
		member do
			get :by_comments
		end
	end
	resources :comments, :only => [:index, :create, :destroy]
  resources :deals do
  	resources :shares
  	member do
  		get :watchers
  		post :score_up
  		post :score_down
  		get :add_to_queue
  		get :make_queue
  		get :make_top_deal
  		get :make_flashback
  		get :frame
  	end
  end
  resources :feedbacks, :only => [:index, :create, :destroy]
  resources :forgot_names
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
	match '/flashback_by_points' => 'deals#flash_points', :as => :flash_points
	match '/flashingdeal/:id' => 'deals#frame', :as => :frame
	match '/flashmob_deals' => 'deals#flashmob_deals', :as => :flashmob_deals
	match '/flashmob_deals_by_comments' => 'deals#flashmob_comments', :as => :flashmob_comments
	match '/remove_watched_deals' => 'deals#remove_watched_deals', :as => :remove_watched_deals
	match '/queue' => 'deals#queue', :as => :queue
	match '/rising_deals' => 'deals#rising_deals', :as => :rising_deals
	match '/home' => 'deals#home', :as => :home
	match '/past_deals' => 'deals#index'
	match '/search' => 'deals#search', :as => :search
	match '/live_search' => 'deals#live_search', :as => :live_search
  match '/create_deals' => 'deals#create_deals', :as => :create_deals
  match '/create_rising_deals' => 'deals#create_rising_deals', :as => :create_rising_deals
	match '/create_flashmob_deals' => 'deals#create_flashmob_deals', :as => :create_flashmob_deals
	match '/empty_queue' => 'deals#empty_queue', :as => :empty_queue
# Messages	
	match '/read_all' => 'messages#read_all', :as => :read_all
  match '/unread_all' => 'messages#unread_all', :as => :unread_all
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
# Sessions  
  match '/login'  => 'sessions#new'
  match '/logout' => 'sessions#destroy'
# Shares  
  match '/remove_shared_deals' => 'shares#remove_shared_deals', :as => :remove_shared_deals
# Users
  match '/signup' => 'users#new'
  match '/my_account' => 'users#my_account', :as => :my_account
  match '/friend_requests' => 'users#friend_requests', :as => :friend_requests
  match '/shared_deals' => 'users#shared_deals', :as => :shared_deals
# 404
  match '*url' => 'pages#page_not_found', :as => :page_not_found
end
