class CreateRiders < ActiveRecord::Migration
  def self.up
    create_table :riders do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :riders
  end
end
