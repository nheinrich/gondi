class ChangeRidersToAthletes < ActiveRecord::Migration
  def self.up
    rename_table :riders, :athletes
  end

  def self.down
    rename_table :athletes, :riders
  end
end
