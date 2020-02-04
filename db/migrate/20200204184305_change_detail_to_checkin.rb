class ChangeDetailToCheckin < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :check_in, :boolean, default: false, null: false
    add_column :checkins, :check_in, :boolean, default: true, null: false
  end
end
