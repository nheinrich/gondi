class UpdateUsersToUseDeviseFacebookModule < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable
      t.facebook_open_graph_authenticatable
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
    end
  end

  def self.down

  end
end
