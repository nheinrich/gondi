class CreateAthletesVideos < ActiveRecord::Migration
  def self.up
    create_table :athletes_videos, :id => false do |t|
      t.integer :athlete_id
      t.integer :video_id
    end

    add_index :athletes_videos, [:athlete_id, :video_id]
  end

  def self.down
    drop_table :athletes_videos
  end
end
