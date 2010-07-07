class ConvertFbUserIdsToString < ActiveRecord::Migration
  def self.up
    change_column :users, :fb_user_id, :string
  end

  def self.down
    change_column :users, :fb_user_id, :integer
  end
end
