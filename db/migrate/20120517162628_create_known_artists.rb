class CreateKnownArtists < ActiveRecord::Migration
  def change
    create_table :known_artists do |t|
      t.string :name

      t.timestamps
    end
  end
end
