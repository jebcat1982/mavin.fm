class DropDislikesTable < ActiveRecord::Migration
  def up
    drop_table :dislikes
  end
end
