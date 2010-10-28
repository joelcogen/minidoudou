class CreateActionTypes < ActiveRecord::Migration
  def self.up
    create_table :action_types do |t|
      t.string :name
      t.string :command

      t.timestamps
    end
  end

  def self.down
    drop_table :action_types
  end
end
