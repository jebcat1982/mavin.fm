class CreateStationTracks < ActiveRecord::Migration
  def change
    create_table :station_tracks do |t|
      t.integer :station_id
      t.integer :track_id

      t.timestamps
    end
  end
end
