class RenameCheckinToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :checkin, :check_in
  end
end
