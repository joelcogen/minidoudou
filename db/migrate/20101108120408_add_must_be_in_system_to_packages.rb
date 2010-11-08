class AddMustBeInSystemToPackages < ActiveRecord::Migration
  def self.up
    add_column :packages, :system_only, :boolean
  end

  def self.down
    remove_column :packages, :system_only
  end
end

