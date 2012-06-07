class AddStationIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :station_id, :integer

  end
end
