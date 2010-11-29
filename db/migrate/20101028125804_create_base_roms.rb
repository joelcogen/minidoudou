class CreateBaseRoms < ActiveRecord::Migration
  def self.up
    create_table :base_roms do |t|
      t.string :name
      t.boolean :old
      t.boolean :dev
      t.string :url
      t.integer :device_id
      t.string :file_path
      t.text :info

      t.timestamps
    end
  end

  def self.down
    drop_table :base_roms
  end
end

