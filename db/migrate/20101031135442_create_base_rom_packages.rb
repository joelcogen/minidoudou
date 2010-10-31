class CreateBaseRomPackages < ActiveRecord::Migration
  def self.up
    create_table :base_rom_packages do |t|
      t.integer :base_rom_id
      t.integer :package_id
      t.boolean :mandatory

      t.timestamps
    end
  end

  def self.down
    drop_table :base_rom_packages
  end
end
