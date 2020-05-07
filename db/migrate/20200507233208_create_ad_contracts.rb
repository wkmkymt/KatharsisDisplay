class CreateAdContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_contracts do |t|
      t.bigint :advertisement_id, null: false
      t.bigint :shop_id, null: false

      t.timestamps
    end
  end
end
