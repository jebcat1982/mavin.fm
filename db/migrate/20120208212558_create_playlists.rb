class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :user_id
      t.integer :session_id
      t.string :search_term

      t.timestamps
    end
  end
end
