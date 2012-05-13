class AddRegisteredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registered, :boolean
  end

  users = User.all
  users.each do |user|
    user.registered = true
    user.save
  end
end
