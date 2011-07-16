class AddUploaderToBaseRom < ActiveRecord::Migration
  def self.up
    add_column :base_roms, :uploader_id, :integer
  end

  def self.down
    remove_column :base_roms, :uploader_id
  end
end
