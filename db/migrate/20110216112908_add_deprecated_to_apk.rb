class AddDeprecatedToApk < ActiveRecord::Migration
  def self.up
    add_column :apks, :deprecated, :boolean
  end

  def self.down
    remove_column :apks, :deprecated
  end
end
