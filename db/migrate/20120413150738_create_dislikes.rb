class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.integer :user_id
      t.string :session_id
      t.integer :track_id

      t.timestamps
    end
  end
end
