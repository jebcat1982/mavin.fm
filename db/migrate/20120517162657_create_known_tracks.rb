class CreateKnownTracks < ActiveRecord::Migration
  def change
    create_table :known_tracks do |t|
      t.string :name
      t.string :artist

      t.timestamps
    end
  end
end
