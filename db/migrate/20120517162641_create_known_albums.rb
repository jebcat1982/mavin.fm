class CreateKnownAlbums < ActiveRecord::Migration
  def change
    create_table :known_albums do |t|
      t.string :name
      t.string :artist

      t.timestamps
    end
  end
end
