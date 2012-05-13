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

ActiveRecord::Schema.define(:version => 20120511203534) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "release_date"
    t.integer  "downloadable"
    t.string   "url"
    t.text     "about"
    t.text     "credits"
    t.string   "small_art_url"
    t.string   "large_art_url"
    t.string   "artist"
    t.integer  "band_id"
    t.integer  "e_id",          :limit => 8
    t.integer  "e_band_id",     :limit => 8
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "source"
  end

  add_index "albums", ["e_id", "source"], :name => "index_albums_on_e_id_and_source", :unique => true

  create_table "bands", :force => true do |t|
    t.string   "url"
    t.integer  "e_id",        :limit => 8
    t.string   "subdomain"
    t.string   "name"
    t.string   "offsite_url"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "source"
  end

  add_index "bands", ["e_id", "source"], :name => "index_bands_on_e_id_and_source", :unique => true

  create_table "dislikes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "playlist_tracks", :force => true do |t|
    t.integer  "playlist_id"
    t.integer  "track_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "playlists", :force => true do |t|
    t.integer  "user_id"
    t.string   "search_term"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "name"
    t.boolean  "deleted",     :default => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.integer  "track_id"
    t.boolean  "liked"
    t.float    "time"
    t.float    "percentage"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "track_id"
    t.integer  "playlist_id"
  end

  create_table "tags", :force => true do |t|
    t.integer  "album_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tracks", :force => true do |t|
    t.string   "title"
    t.integer  "number"
    t.float    "duration"
    t.integer  "release_date"
    t.integer  "downloadable"
    t.string   "url"
    t.string   "streaming_url"
    t.text     "lyrics"
    t.text     "about"
    t.text     "credits"
    t.string   "small_art_url"
    t.string   "large_art_url"
    t.string   "artist"
    t.integer  "album_id"
    t.integer  "e_id",           :limit => 8
    t.integer  "e_album_id",     :limit => 8
    t.integer  "e_band_id",      :limit => 8
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "album_title"
    t.string   "album_url"
    t.string   "artist_url"
    t.string   "band_subdomain"
    t.string   "source"
  end

  add_index "tracks", ["e_id", "source"], :name => "index_tracks_on_e_id_and_source", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "registered"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
