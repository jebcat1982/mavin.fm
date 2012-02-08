class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :url
      t.integer :e_id
      t.string :subdomain
      t.string :name
      t.string :offsite_url

      t.timestamps
    end
  end
end
