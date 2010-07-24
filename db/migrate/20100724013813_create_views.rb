class CreateViews < ActiveRecord::Migration
  def self.up
    create_table :views do |t|
      t.column :user_id, :integer
      t.column :video_id, :integer
      t.column :total, :integer
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :views
  end
end
