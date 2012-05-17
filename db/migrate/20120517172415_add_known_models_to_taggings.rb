class AddKnownModelsToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :known_artist_id, :integer

    add_column :taggings, :known_album_id, :integer

    add_column :taggings, :known_track_id, :integer

  end
end
