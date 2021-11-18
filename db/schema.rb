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

ActiveRecord::Schema.define(version: 2021_11_18_160035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "plpgsql"

  create_table "recipes", force: :cascade do |t|
    t.float "rate", default: 0.0
    t.string "author_tip"
    t.integer "prep_time", default: 0
    t.string "budget"
    t.string "name", null: false
    t.string "difficulty"
    t.integer "people_quantity"
    t.integer "cook_time", default: 0
    t.integer "total_time", default: 0
    t.integer "nb_comments"
    t.string "image"
    t.string "author"
    t.text "tags", default: [], array: true
    t.text "ingredients", default: "{}"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredients"], name: "index_recipes_on_ingredients", using: :gin
    t.index ["name"], name: "unique_recipes"
    t.index ["tags"], name: "index_recipes_on_tags", using: :gin
  end

end
