class RemoveExpertFromApks < ActiveRecord::Migration
  def self.up
    remove_column :apks, :expert
  end

  def self.down
    add_column :apks, :expert, :boolean
  end
end
