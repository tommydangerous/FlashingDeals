FlashingDeal::Application.routes.draw do

	resources :authentications
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
  		get :make_dead
  		get :show_overlay
  	end
  end
  resources :editmarks
  resources :feedbacks, :only => [:index, :create, :destroy]
  resources :forgot_names
  resources :friendships, :only => [:create, :update, :destroy]
  resources :locations, :only => :show
  resources :messages, :only => [:index, :show, :create, :update]
  resources :newsletters
  resources :notifications, :only => :index
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :referrals, :only => :index
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
# Authentications
	match '/auth/:provider/callback' => 'authentications#create'
	match '/auth/failure' => 'authentications#failure'
# Deals
  root :to => 'deals#featured_deals'
  match '/featured' => 'deals#featured_deals', :as => :featured_deals
	match '/featured_deals' => 'deals#flashback', :as => :flashback
	match '/flashingdeal/:id' => 'deals#frame', :as => :frame
	match '/community' => 'deals#community_deals', :as => :community_deals
	match '/flashmob-deals' => 'deals#flashmob_deals', :as => :flashmob_deals
	match '/remove-watched-deals' => 'deals#remove_watched_deals', :as => :remove_watched_deals
	match '/clear-dead-deals' => 'deals#clear_dead_deals', :as => :clear_dead_deals
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
  match '/test2' => 'pages#test2', :as => :test2
  match '/contacts/failure' => 'pages#contacts_failure'
# Sessions  
  match '/login'  => 'sessions#new'
  match '/logout' => 'sessions#destroy'
  match '/hide-featured' => 'sessions#hide_featured', :as => :hide_featured
  match '/hide-community' => 'sessions#hide_community', :as => :hide_community
  match '/hide-category' => 'sessions#hide_category', :as => :hide_category
  
  match '/hide-signup-message' => 'sessions#hide_signup_message', :as => :hide_signup_message
  match '/hide-featured-deals-info' => 'sessions#hide_flashback_info', :as => :hide_flashback_info
  match '/hide-community-deals-info' => 'sessions#hide_flashmob_info', :as => :hide_flashmob_info
  match '/hide-categories-info' => 'sessions#hide_categories_info', :as => :hide_categories_info
# Shares  
  match '/remove-shared-deals' => 'shares#remove_shared_deals', :as => :remove_shared_deals
# Users
  match '/signup' => 'users#new'
  match '/me' => 'users#my_deals', :as => :my_account
  match '/friends' => 'users#my_friends', :as => :my_friends
  match '/friend-requests' => 'users#friend_requests', :as => :friend_requests
  match '/shared' => 'users#shared', :as => :shared_deals
  match '/invite' => 'users#invite', :as => :invite
  match '/invite-gmail' => 'users#invite_gmail', :as => :invite_gmail
  match "/signup/:id" => 'users#signup', :as => :referral_signup_path
  match '/email-invites' => 'users#email_invite', :as => :email_invite
  match '/gmail-invites' => 'users#gmail_invite', :as => :gmail_invite
# Friends
	match '/user/list/friends/friends-list' => 'friends#friends_list', :as => :friends
# Ajax
	match '/ajax' => 'ajax#ajax'
	match '/ajax/ajax_received_messages' => 'ajax#ajax_received_messages'
	match '/ajax/ajax_friend_requests' => 'ajax#ajax_friend_requests'
	match '/ajax/ajax_shared_deals' => 'ajax#ajax_shared_deals'
	match '/ajax/ajax_notification' => 'ajax#ajax_notification'
	match '/ajax/ajax_notifications_update' => 'ajax#ajax_notifications_update'
# 404
  match '*url' => 'pages#page_not_found', :as => :page_not_found
end
