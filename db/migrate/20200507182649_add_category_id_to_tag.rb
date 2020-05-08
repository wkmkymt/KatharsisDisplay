class AddCategoryIdToTag < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :category_id, :bigint, null: false
  end
end
