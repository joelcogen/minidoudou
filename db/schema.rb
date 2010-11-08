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

ActiveRecord::Schema.define(:version => 20101108120408) do

  create_table "base_rom_packages", :force => true do |t|
    t.integer  "base_rom_id"
    t.integer  "package_id"
    t.boolean  "mandatory"
    t.boolean  "dev"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "base_roms", :force => true do |t|
    t.string   "name"
    t.boolean  "old"
    t.boolean  "dev"
    t.string   "url"
    t.integer  "device_id"
    t.string   "file_path"
    t.text     "to_remove"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configuration_packages", :force => true do |t|
    t.integer  "configuration_id"
    t.integer  "package_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.integer  "base_rom_id"
    t.string   "file_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "system_size"
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.boolean  "old"
    t.string   "file_path"
    t.boolean  "apk"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "system_only"
  end

end
