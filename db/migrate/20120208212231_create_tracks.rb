class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :number
      t.float :duration
      t.integer :release_date
      t.integer :downloadable
      t.string :url
      t.string :streaming_url
      t.text :lyrics
      t.text :about
      t.text :credits
      t.string :small_art_url
      t.string :large_art_url
      t.string :artist
      t.integer :album_id
      t.integer :e_id
      t.integer :e_album_id
      t.integer :e_band_id

      t.timestamps
    end
  end
end
