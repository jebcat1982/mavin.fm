class ChangePlaylistSessionIdToString < ActiveRecord::Migration
  def change
    change_column :playlists, :session_id, :string
  end
end
