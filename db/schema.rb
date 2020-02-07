# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_07_173131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dish_courses", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_dish_courses_on_course_id"
    t.index ["dish_id"], name: "index_dish_courses_on_dish_id"
  end

  create_table "dish_cuisines", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "cuisine_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cuisine_id"], name: "index_dish_cuisines_on_cuisine_id"
    t.index ["dish_id"], name: "index_dish_cuisines_on_dish_id"
  end

  create_table "dish_diets", force: :cascade do |t|
    t.bigint "dish_id", null: false
    t.bigint "diet_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diet_id"], name: "index_dish_diets_on_diet_id"
    t.index ["dish_id"], name: "index_dish_diets_on_dish_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "api_id"
    t.string "photo"
    t.boolean "is_recipe"
    t.bigint "recipe_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_dishes_on_recipe_id"
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_favorites_on_recipe_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "api_id"
    t.string "title"
    t.string "photo"
    t.float "rating"
    t.integer "servings"
    t.integer "cook_time"
    t.string "ingredients"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "directions", default: [], array: true
    t.string "source_url"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "telephone"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_diets", force: :cascade do |t|
    t.bigint "diet_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diet_id"], name: "index_user_diets_on_diet_id"
    t.index ["user_id"], name: "index_user_diets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "name"
    t.string "region"
    t.string "email"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "dish_courses", "courses"
  add_foreign_key "dish_courses", "dishes"
  add_foreign_key "dish_cuisines", "cuisines"
  add_foreign_key "dish_cuisines", "dishes"
  add_foreign_key "dish_diets", "diets"
  add_foreign_key "dish_diets", "dishes"
  add_foreign_key "dishes", "recipes"
  add_foreign_key "dishes", "restaurants"
  add_foreign_key "favorites", "recipes"
  add_foreign_key "favorites", "users"
  add_foreign_key "user_diets", "diets"
  add_foreign_key "user_diets", "users"
end
