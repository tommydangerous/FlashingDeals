# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120402134410) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id", "provider", "uid"], :name => "index_authentications_on_user_id_and_provider_and_uid", :unique => true

  create_table "bonds", :force => true do |t|
    t.integer   "deal_id"
    t.integer   "location_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "bonds", ["deal_id", "location_id"], :name => "index_bonds_on_deal_id_and_location_id", :unique => true
  add_index "bonds", ["deal_id"], :name => "index_bonds_on_deal_id"
  add_index "bonds", ["location_id"], :name => "index_bonds_on_location_id"

  create_table "categories", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "permalink"
    t.string    "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "comments", :force => true do |t|
    t.text      "content"
    t.integer   "user_id"
    t.integer   "deal_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "weight"
  end

  add_index "comments", ["deal_id", "created_at"], :name => "index_comments_on_deal_id_and_created_at"
  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "connections", :force => true do |t|
    t.integer   "deal_id"
    t.integer   "category_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "connections", ["category_id"], :name => "index_connections_on_category_id"
  add_index "connections", ["deal_id", "category_id"], :name => "index_connections_on_deal_id_and_category_id", :unique => true
  add_index "connections", ["deal_id"], :name => "index_connections_on_deal_id"

  create_table "deals", :force => true do |t|
    t.string    "name"
    t.float     "price"
    t.float     "value"
    t.float     "discount"
    t.float     "savings"
    t.text      "image"
    t.text      "link"
    t.string    "site"
    t.float     "rating"
    t.float     "up_rating"
    t.float     "down_rating"
    t.float     "metric"
    t.string    "tag"
    t.timestamp "posted"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "click_count",   :default => 0
    t.integer   "view_count",    :default => 0
    t.string    "city"
    t.text      "info"
    t.boolean   "top_deal",      :default => false
    t.boolean   "flash_back",    :default => false
    t.integer   "deal_order"
    t.boolean   "queue",         :default => false
    t.timestamp "time_in"
    t.timestamp "time_out"
    t.string    "slug"
    t.integer   "point_count",   :default => 0
    t.integer   "comment_count", :default => 0
    t.boolean   "exclusive"
    t.string    "coupon"
    t.string    "rebate"
    t.boolean   "dead",          :default => false
    t.boolean   "flashmob",      :default => false
  end

  add_index "deals", ["city"], :name => "index_deals_on_city"
  add_index "deals", ["click_count"], :name => "index_deals_on_click_count"
  add_index "deals", ["comment_count"], :name => "index_deals_on_comment_count"
  add_index "deals", ["coupon"], :name => "index_deals_on_coupon"
  add_index "deals", ["created_at"], :name => "index_deals_on_created_at"
  add_index "deals", ["dead"], :name => "index_deals_on_dead"
  add_index "deals", ["deal_order"], :name => "index_deals_on_deal_order"
  add_index "deals", ["discount"], :name => "index_deals_on_discount"
  add_index "deals", ["exclusive"], :name => "index_deals_on_exclusive"
  add_index "deals", ["flash_back"], :name => "index_deals_on_flash_back"
  add_index "deals", ["flashmob"], :name => "index_deals_on_flashmob"
  add_index "deals", ["link"], :name => "index_deals_on_link"
  add_index "deals", ["metric"], :name => "index_deals_on_metric"
  add_index "deals", ["name"], :name => "index_deals_on_name", :unique => true
  add_index "deals", ["point_count"], :name => "index_deals_on_point_count"
  add_index "deals", ["posted"], :name => "index_deals_on_posted"
  add_index "deals", ["price"], :name => "index_deals_on_price"
  add_index "deals", ["queue"], :name => "index_deals_on_queue"
  add_index "deals", ["rebate"], :name => "index_deals_on_rebate"
  add_index "deals", ["savings"], :name => "index_deals_on_savings"
  add_index "deals", ["site"], :name => "index_deals_on_site"
  add_index "deals", ["slug"], :name => "index_deals_on_slug"
  add_index "deals", ["tag"], :name => "index_deals_on_tag"
  add_index "deals", ["time_in"], :name => "index_deals_on_time_in"
  add_index "deals", ["time_out"], :name => "index_deals_on_time_out"
  add_index "deals", ["top_deal"], :name => "index_deals_on_top_deal"
  add_index "deals", ["updated_at"], :name => "index_deals_on_updated_at"
  add_index "deals", ["value"], :name => "index_deals_on_value"
  add_index "deals", ["view_count"], :name => "index_deals_on_view_count"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "editmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "deal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "editmarks", ["user_id", "deal_id"], :name => "index_editmarks_on_user_id_and_deal_id", :unique => true

  create_table "feedbacks", :force => true do |t|
    t.integer   "user_id"
    t.string    "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "feedbacks", ["user_id", "created_at"], :name => "index_feedbacks_on_user_id_and_created_at"

  create_table "friendships", :force => true do |t|
    t.integer   "user_id"
    t.integer   "friend_id"
    t.boolean   "approved"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id", :unique => true

  create_table "locations", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "permalink"
    t.string    "slug"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"
  add_index "locations", ["slug"], :name => "index_locations_on_slug"

  create_table "messages", :force => true do |t|
    t.text      "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.integer   "recipient_id"
    t.boolean   "read",         :default => false
  end

  add_index "messages", ["created_at"], :name => "index_messages_on_created_at"
  add_index "messages", ["user_id", "recipient_id"], :name => "index_messages_on_user_id_and_recipient_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "notice_id"
    t.integer  "deal_id"
    t.integer  "comment_id"
    t.integer  "subcomment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read"
  end

  add_index "notifications", ["read"], :name => "index_notifications_on_read"
  add_index "notifications", ["user_id", "notice_id", "deal_id", "comment_id", "subcomment_id"], :name => "notifications_index", :unique => true

  create_table "referrals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "referred_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "referrals", ["user_id", "referred_id"], :name => "index_referrals_on_user_id_and_referred_id", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer   "watcher_id"
    t.integer   "watched_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "relationships", ["watched_id"], :name => "index_relationships_on_watched_id"
  add_index "relationships", ["watcher_id", "watched_id"], :name => "index_relationships_on_watcher_id_and_watched_id", :unique => true
  add_index "relationships", ["watcher_id"], :name => "index_relationships_on_watcher_id"

  create_table "shares", :force => true do |t|
    t.integer   "user_id"
    t.integer   "friend_id"
    t.integer   "deal_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "shares", ["user_id", "friend_id", "deal_id"], :name => "index_shares_on_user_id_and_friend_id_and_deal_id", :unique => true

  create_table "subcomments", :force => true do |t|
    t.text      "content"
    t.integer   "user_id"
    t.integer   "comment_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "deal_id"
  end

  add_index "subcomments", ["comment_id"], :name => "index_subcomments_on_comment_id"
  add_index "subcomments", ["deal_id"], :name => "index_subcomments_on_deal_id"
  add_index "subcomments", ["user_id"], :name => "index_subcomments_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",                  :default => false
    t.integer  "deal_duration",          :default => 1
    t.boolean  "private",                :default => false
    t.boolean  "accept_terms",           :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "slug"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "gm",                     :default => false
    t.string   "time_zone",              :default => "Pacific Time (US & Canada)"
    t.datetime "active"
    t.string   "image_remote_url"
  end

  add_index "users", ["active"], :name => "index_users_on_active"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "votes", :force => true do |t|
    t.boolean   "vote",          :default => false
    t.integer   "voteable_id",                      :null => false
    t.string    "voteable_type",                    :null => false
    t.integer   "voter_id"
    t.string    "voter_type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
