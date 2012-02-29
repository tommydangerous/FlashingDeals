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
  resources :friendships, :only => [:create, :update, :destroy]
  resources :locations, :only => :show
  resources :messages, :only => [:index, :show, :create, :update]
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :relationships, :only => [:index, :create, :destroy]
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
	match '/featured-deals' => 'deals#flashback', :as => :flashback
	match '/flashingdeal/:id' => 'deals#frame', :as => :frame
	match '/community-deals' => 'deals#flashmob_deals', :as => :flashmob_deals
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
  match '/control-panel' => 'pages#control_panel', :as => :control_panel
# Sessions  
  match '/login'  => 'sessions#new'
  match '/logout' => 'sessions#destroy'
  match '/hide-signup-message' => 'sessions#hide_signup_message', :as => :hide_signup_message
  match '/hide-featured-deals-info' => 'sessions#hide_flashback_info', :as => :hide_flashback_info
  match '/hide-community-deals-info' => 'sessions#hide_flashmob_info', :as => :hide_flashmob_info
  match '/hide-categories-info' => 'sessions#hide_categories_info', :as => :hide_categories_info
# Shares  
  match '/remove-shared-deals' => 'shares#remove_shared_deals', :as => :remove_shared_deals
# Users
  match '/signup' => 'users#new'
  match '/my-account' => 'users#my_account', :as => :my_account
  match '/friend-requests' => 'users#friend_requests', :as => :friend_requests
  match '/shared-deals' => 'users#shared_deals', :as => :shared_deals
# Friends
	match '/user/list/friends/friends-list' => 'friends#friends_list', :as => :friends
# Ajax
	match '/ajax' => 'ajax#ajax'
	match '/ajax/ajax_received_messages' => 'ajax#ajax_received_messages'
	match '/ajax/ajax_friend_requests' => 'ajax#ajax_friend_requests'
	match '/ajax/ajax_shared_deals' => 'ajax#ajax_shared_deals'
	match '/ajax/ajax_notification' => 'ajax#ajax_notification'
# 404
  match '*url' => 'pages#page_not_found', :as => :page_not_found
end
