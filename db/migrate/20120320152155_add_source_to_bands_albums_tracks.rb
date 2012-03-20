class AddSourceToBandsAlbumsTracks < ActiveRecord::Migration
  def change
    add_column :bands,  :source, :string
    add_column :albums, :source, :string
    add_column :tracks, :source, :string

    add_index :bands,  [:e_id, :source], :unique => true
    add_index :albums, [:e_id, :source], :unique => true
    add_index :tracks, [:e_id, :source], :unique => true
  end
end
