class AddShopIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :shop_id, :bigint
  end
end
