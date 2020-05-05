class AddCheckinPointToShop < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :checkin_point, :integer, default: 1, null: false
  end
end
