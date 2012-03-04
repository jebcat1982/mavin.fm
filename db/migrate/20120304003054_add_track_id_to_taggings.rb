class AddTrackIdToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :track_id, :integer

  end
end
