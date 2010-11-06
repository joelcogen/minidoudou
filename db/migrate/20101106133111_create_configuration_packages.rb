class CreateConfigurationPackages < ActiveRecord::Migration
  def self.up
    create_table :configuration_packages do |t|
      t.integer :configuration_id
      t.integer :package_id

      t.timestamps
    end
  end

  def self.down
    drop_table :configuration_packages
  end
end
