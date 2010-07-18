class RenameLinkToProvider < ActiveRecord::Migration
  def self.up
    rename_column :videos, :link, :provider
    add_column :videos, :provider_id, :string

    rename_column :videos, :source, :source_url
  end

  def self.down
    rename_column :videos, :provider, :link
    remove_column :videos, :provider_id

    rename_column :videos, :source_url, :source
  end
end
