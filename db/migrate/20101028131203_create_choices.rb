class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.integer :base_rom_id
      t.boolean :include_nil
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :choices
  end
end
