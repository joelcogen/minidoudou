class CreateApks < ActiveRecord::Migration
  def self.up
    create_table :apks do |t|
      t.integer :base_rom_id
      t.string :name
      t.string :description
      t.string :location
      t.boolean :expert

      t.timestamps
    end
  end

  def self.down
    drop_table :apks
  end
end
