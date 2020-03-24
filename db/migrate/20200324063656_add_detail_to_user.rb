class AddDetailToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer
    add_column :users, :birthday, :date
    add_column :users, :color_id, :bigint
    add_column :users, :profimg_id, :bigint
  end
end
