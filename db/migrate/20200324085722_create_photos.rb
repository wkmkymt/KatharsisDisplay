class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.binary :image, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
