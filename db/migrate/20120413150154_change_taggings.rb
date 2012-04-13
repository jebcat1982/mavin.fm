class ChangeTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :playlist_id, :integer
    remove_column :taggings, :album_id
  end
end
