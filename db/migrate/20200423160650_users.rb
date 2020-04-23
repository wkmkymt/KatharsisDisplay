class Users < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :personality, :integer, default: 0, null: false
  end
end
