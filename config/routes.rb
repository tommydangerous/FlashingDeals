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
  resources :newsletters do
  	member do
  		get :email
  		get :subscribed
  		post :select
  	end
  end
  resources :notifications, :only => :index
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :referrals, :only => :index
  resources :relationships, :only => [:index, :create, :destroy]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :shares, :only => [:create, :destroy]
  resources :stars, :only => :create
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
	match '/signup/twitter/email' => 'authentications#twitter_email', :as => :twitter_email
	match '/signup/twitter/email/new' => 'authentications#twitter_new', :as => :twitter_new
	
	match '/auth_google' => 'authentications#auth_google', :as => :auth_google
	match '/auth_google_token' => 'authentications#auth_google_token', :as => :auth_google_token
	match '/auth_google_create' => 'authentications#auth_google_create', :as => :auth_google_create
# Deals
  root :to => 'deals#featured_deals'
  match '/featured' => 'deals#featured_deals', :as => :featured_deals
	match '/flashingdeal/:id' => 'deals#frame', :as => :frame
	match '/community' => 'deals#community_deals', :as => :community_deals
	match '/flashmob-deals' => 'deals#flashmob_deals', :as => :flashmob_deals
	match '/clear-dead-deals' => 'deals#clear_dead_deals', :as => :clear_dead_deals
	match '/queue' => 'deals#queue', :as => :queue
	match '/rising-deals' => 'deals#rising_deals', :as => :rising_deals
	match '/search' => 'deals#search', :as => :search
  match '/create-deals' => 'deals#create_deals', :as => :create_deals
	match '/empty-queue' => 'deals#empty_queue', :as => :empty_queue
	match '/featured/all' => 'deals#featured_deals_all', :as => :featured_deals_all
# Friendships
	match '/friendships/accept/:name' => 'friendships#accept'
# Messages	
	match '/read-all' => 'messages#read_all', :as => :read_all
  match '/unread-all' => 'messages#unread_all', :as => :unread_all
# Newsletters
	match '/subscribed-users' => 'newsletters#subscribed_users', :as => :subscribed_users
	match '/unsubscribed-users' => 'newsletters#unsubscribed_users', :as => :unsubscribed_users
	match '/monthly-subscribed-users' => 'newsletters#monthly_subscribed_users', :as => :monthly_subscribed_users
	match '/unsubscribed-reply-alert-users' => 'newsletters#unsubscribed_reply_alert_users', :as => :unsubscribed_reply_alert_users
	match '/unsubscribed-friend-alert-users' => 'newsletters#unsubscribed_friend_alert_users', :as => :unsubscribed_friend_alert_users
	match '/email-subscribed-users' => 'newsletters#email_subscribed_users', :as => :email_subscribed_users
	match '/email-select-users' => 'newsletters#email_select_users', :as => :email_select_users
# Pages
  match '/about' => 'pages#about', :as => :about
  match '/team' => 'pages#team', :as => :team
  match '/partner' => 'pages#partner', :as => :partner
  match '/support' => 'pages#support', :as => :support
  match '/contact' => 'pages#contact', :as => :contact
  match '/terms' => 'pages#terms', :as => :terms
  match '/privacy' => 'pages#privacy', :as => :privacy
  
  match '/test' => 'pages#test', :as => :test
  match '/test2' => 'pages#test2', :as => :test2
  match '/contacts/failure' => 'pages#contacts_failure'
# Partners
	match '/satori' => 'partners#satori_deals', :as => :satori_deals
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
  match '/feed' => 'users#my_feed', :as => :my_account
  match '/my-deals' => 'users#my_deals', :as => :my_deals
  match '/my-friends' => 'users#my_friends', :as => :my_friends
  match '/friend-requests' => 'users#friend_requests', :as => :friend_requests
  match '/shared' => 'users#shared', :as => :shared_deals
  match '/invite' => 'users#invite', :as => :invite
  match '/invite-gmail' => 'users#invite_gmail', :as => :invite_gmail
  match "/signup/:id" => 'users#signup', :as => :referral_signup_path
  match '/email-invites' => 'users#email_invite', :as => :email_invite
  match '/gmail-invites' => 'users#gmail_invite', :as => :gmail_invite
  match '/unsubscribe' => 'users#unsubscribe', :as => :unsubscribe
  match '/unsubscribe-me' => 'users#unsubscribe_me', :as => :unsubscribe_me
  match '/unsubscribe-reply-alerts' => 'users#unsubscribe_reply_alert', :as => :unsubscribe_reply_alert
  match '/unsubscribe-reply-alerts-me' => 'users#unsubscribe_reply_alert_me', :as => :unsubscribe_reply_alert_me
  match '/unsubscribe-friend-alerts' => 'users#unsubscribe_friend_alert', :as => :unsubscribe_friend_alert
  match '/unsubscribe-friend-alerts-me' => 'users#unsubscribe_friend_alert_me', :as => :unsubscribe_friend_alert_me
  match '/email-monthly' => 'users#email_monthly', :as => :email_monthly
  match '/game-room' => 'users#game_room', :as => :game_room
  match '/user-sent-invite' => 'users#user_sent_invite', :as => :user_sent_invite
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
