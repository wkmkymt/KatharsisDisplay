class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.bigint :src_user_id, null: false
      t.bigint :target_user_id, null: false
      t.integer :rate, null: false
      t.text :comment

      t.timestamps
    end

    add_index :reviews, :src_user_id
    add_index :reviews, :target_user_id
  end
end
