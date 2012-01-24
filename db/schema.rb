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

ActiveRecord::Schema.define(:version => 20120123144046) do

  create_table "bonds", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bonds", ["deal_id", "location_id"], :name => "index_bonds_on_deal_id_and_location_id", :unique => true
  add_index "bonds", ["deal_id"], :name => "index_bonds_on_deal_id"
  add_index "bonds", ["location_id"], :name => "index_bonds_on_location_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.string   "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "deal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
  end

  add_index "comments", ["deal_id", "created_at"], :name => "index_comments_on_deal_id_and_created_at"
  add_index "comments", ["user_id", "created_at"], :name => "index_comments_on_user_id_and_created_at"

  create_table "connections", :force => true do |t|
    t.integer  "deal_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["category_id"], :name => "index_connections_on_category_id"
  add_index "connections", ["deal_id", "category_id"], :name => "index_connections_on_deal_id_and_category_id", :unique => true
  add_index "connections", ["deal_id"], :name => "index_connections_on_deal_id"

  create_table "deals", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.float    "value"
    t.float    "discount"
    t.float    "savings"
    t.string   "image"
    t.string   "link"
    t.string   "site"
    t.float    "rating"
    t.float    "up_rating"
    t.float    "down_rating"
    t.float    "metric"
    t.string   "tag"
    t.datetime "posted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "click_count"
    t.integer  "view_count"
    t.string   "city"
    t.string   "info"
    t.boolean  "top_deal",    :default => false
    t.boolean  "flash_back",  :default => false
    t.integer  "deal_order"
    t.boolean  "queue",       :default => false
    t.datetime "time_in"
    t.datetime "time_out"
    t.string   "slug"
  end

  add_index "deals", ["city"], :name => "index_deals_on_city"
  add_index "deals", ["deal_order"], :name => "index_deals_on_deal_order"
  add_index "deals", ["flash_back"], :name => "index_deals_on_flash_back"
  add_index "deals", ["metric"], :name => "index_deals_on_metric"
  add_index "deals", ["name"], :name => "index_deals_on_name", :unique => true
  add_index "deals", ["queue"], :name => "index_deals_on_queue"
  add_index "deals", ["slug"], :name => "index_deals_on_slug"
  add_index "deals", ["top_deal"], :name => "index_deals_on_top_deal"

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["user_id", "created_at"], :name => "index_feedbacks_on_user_id_and_created_at"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.string   "slug"
  end

  add_index "locations", ["name"], :name => "index_locations_on_name"
  add_index "locations", ["slug"], :name => "index_locations_on_slug"

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.boolean  "read",         :default => false
  end

  add_index "messages", ["created_at"], :name => "index_messages_on_created_at"
  add_index "messages", ["user_id", "recipient_id"], :name => "index_messages_on_user_id_and_recipient_id"

  create_table "relationships", :force => true do |t|
    t.integer  "watcher_id"
    t.integer  "watched_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["watched_id"], :name => "index_relationships_on_watched_id"
  add_index "relationships", ["watcher_id", "watched_id"], :name => "index_relationships_on_watcher_id_and_watched_id", :unique => true
  add_index "relationships", ["watcher_id"], :name => "index_relationships_on_watcher_id"

  create_table "shares", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "deal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shares", ["user_id", "friend_id", "deal_id"], :name => "index_shares_on_user_id_and_friend_id_and_deal_id", :unique => true

  create_table "subcomments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deal_id"
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
