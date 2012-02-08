class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :release_date
      t.integer :downloadable
      t.string :url
      t.text :about
      t.text :credits
      t.string :small_art_url
      t.string :large_art_url
      t.string :artist
      t.integer :band_id
      t.integer :e_id
      t.integer :e_band_id

      t.timestamps
    end
  end
end
