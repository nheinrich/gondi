class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :title
      t.string :width
      t.string :height
      t.string :user_id
      t.string :status
      t.string :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
