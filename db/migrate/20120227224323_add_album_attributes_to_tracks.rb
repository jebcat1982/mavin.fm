class AddAlbumAttributesToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :album_title, :string

    add_column :tracks, :album_url, :string

    add_column :tracks, :artist_url, :string

    add_column :tracks, :band_subdomain, :string

  end
end
