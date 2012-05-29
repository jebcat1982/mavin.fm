class AddStationIdToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :station_id, :integer

  end
end
