class RenameIdToReview < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :src_user_id, :reviewer_id
    rename_column :reviews, :target_user_id, :reviewed_id

    add_index :reviews, [:reviewer_id, :reviewed_id], unique: true
  end
end
