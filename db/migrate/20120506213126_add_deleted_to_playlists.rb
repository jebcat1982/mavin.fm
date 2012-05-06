class AddDeletedToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :deleted, :boolean, default: false

  end
end
