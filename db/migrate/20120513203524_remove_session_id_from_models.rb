class RemoveSessionIdFromModels < ActiveRecord::Migration
  def up
    remove_column :dislikes, :session_id
    remove_column :likes, :session_id
    remove_column :playlists, :session_id
    remove_column :ratings, :session_id
  end
end
