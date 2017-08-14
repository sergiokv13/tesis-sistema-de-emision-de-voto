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

ActiveRecord::Schema.define(version: 20170813064559) do

  create_table "estados", force: :cascade do |t|
    t.string "estado"
    t.integer "id_en_linea"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opcions", force: :cascade do |t|
    t.text "informacion"
    t.string "nombre"
    t.string "direccion"
    t.integer "partido_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partido_id"], name: "index_opcions_on_partido_id"
  end

  create_table "partidos", force: :cascade do |t|
    t.string "nombre"
    t.text "informacion"
    t.text "color"
    t.text "color_secundario"
    t.text "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votacions", force: :cascade do |t|
    t.text "razon"
    t.datetime "inicio"
    t.datetime "finalizacion"
    t.integer "tiempo_maximo_votos"
    t.string "etapa"
    t.integer "balotas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votos", force: :cascade do |t|
    t.string "direccion_votante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
