class DropLikesTable < ActiveRecord::Migration
  def up
    drop_table :likes
  end
end
