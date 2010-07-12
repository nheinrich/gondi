class AddColumnsToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :duration, :string
    add_column :videos, :link, :string
    add_column :videos, :source, :string
    remove_column :videos, :published_at
  end

  def self.down
    remove_column :videos, :duration
    remove_column :videos, :link
    remove_column :videos, :source
    add_column :videos, :published_at, :string
  end
end
