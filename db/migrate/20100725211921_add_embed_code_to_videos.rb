class AddEmbedCodeToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :embed, :text
  end

  def self.down
    remove_column :videos, :embed
  end
end
