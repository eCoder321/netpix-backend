# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_27_094349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genre_movies", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "genre_id", null: false
    t.bigint "show_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_genre_movies_on_genre_id"
    t.index ["movie_id"], name: "index_genre_movies_on_movie_id"
    t.index ["show_id"], name: "index_genre_movies_on_show_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id"
    t.bigint "show_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_lists_on_movie_id"
    t.index ["show_id"], name: "index_lists_on_show_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.string "release_date"
    t.string "runtime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "src"
  end

  create_table "shows", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.string "last_air_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "genre_movies", "genres"
  add_foreign_key "genre_movies", "movies"
  add_foreign_key "genre_movies", "shows"
  add_foreign_key "lists", "movies"
  add_foreign_key "lists", "shows"
  add_foreign_key "lists", "users"
end
