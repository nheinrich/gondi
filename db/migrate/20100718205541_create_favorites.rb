class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.column :user_id, :integer
      t.column :video_id, :integer
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :favorites
  end
end
