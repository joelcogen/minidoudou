class CreateChanges < ActiveRecord::Migration
  def self.up
    create_table :changes do |t|
      t.integer :apk_id
      t.string :destination
      t.integer :configuration_id

      t.timestamps
    end
  end

  def self.down
    drop_table :changes
  end
end
