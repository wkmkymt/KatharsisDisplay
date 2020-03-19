class ChangeDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :profile, :comment
    add_column :users, :point, :integer, default: 0, null:false
    add_column :users, :checkin, :boolean, default: false, null: false
  end
end
