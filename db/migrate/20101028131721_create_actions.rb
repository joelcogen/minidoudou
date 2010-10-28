class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.integer :action_type_id
      t.integer :option_id
      t.integer :base_rom_id
      t.text :parameters

      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
