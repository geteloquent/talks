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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140425192831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audiences", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audiences_talks", id: false, force: true do |t|
    t.integer "audience_id", null: false
    t.integer "talk_id",     null: false
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "references", force: true do |t|
    t.string   "url"
    t.integer  "talk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "talks", force: true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.date     "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",    default: 0
    t.integer  "cached_votes_score",    default: 0
    t.integer  "cached_votes_up",       default: 0
    t.integer  "cached_votes_down",     default: 0
    t.integer  "cached_weighted_score", default: 0
    t.integer  "user_id"
  end

  add_index "talks", ["cached_votes_down"], name: "index_talks_on_cached_votes_down", using: :btree
  add_index "talks", ["cached_votes_score"], name: "index_talks_on_cached_votes_score", using: :btree
  add_index "talks", ["cached_votes_total"], name: "index_talks_on_cached_votes_total", using: :btree
  add_index "talks", ["cached_votes_up"], name: "index_talks_on_cached_votes_up", using: :btree
  add_index "talks", ["cached_weighted_score"], name: "index_talks_on_cached_weighted_score", using: :btree
  add_index "talks", ["slug"], name: "index_talks_on_slug", unique: true, using: :btree
  add_index "talks", ["user_id"], name: "index_talks_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.string   "avatar_url"
    t.string   "github_uid"
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
