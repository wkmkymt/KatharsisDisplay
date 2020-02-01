class CreateInterests < ActiveRecord::Migration[5.2]
  def change
    create_table :interests do |t|
      t.bigint :user_id, null: false
      t.bigint :tag_id, null: false

      t.timestamps
    end

    add_index :interests, :user_id
    add_index :interests, :tag_id
  end
end
