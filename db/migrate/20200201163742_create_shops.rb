class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :address
      t.text :description

      t.timestamps
    end

    add_index :shops, :name
  end
end
