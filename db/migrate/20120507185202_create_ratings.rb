class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.string :session_id
      t.integer :playlist_id
      t.integer :track_id
      t.boolean :liked
      t.float :time
      t.float :percentage

      t.timestamps
    end
  end
end
