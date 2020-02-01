class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.bigint :user_id, null: false
      t.bigint :shop_id, null: false

      t.timestamps
    end

    add_index :checkins, :user_id
    add_index :checkins, :shop_id
  end
end
