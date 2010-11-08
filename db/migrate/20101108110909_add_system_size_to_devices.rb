class AddSystemSizeToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :system_size, :integer
  end

  def self.down
    remove_column :devices, :system_size
  end
end

