class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :encrypted_password, :string, null: true
  end

  def down
    change_column :users, :encrypted_password, :string, null: false
  end
end
