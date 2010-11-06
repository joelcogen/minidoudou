class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.string :name
      t.integer :base_rom_id
      t.string :file_path

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
