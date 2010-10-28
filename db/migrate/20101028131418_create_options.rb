class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options do |t|
      t.integer :choice_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :options
  end
end
