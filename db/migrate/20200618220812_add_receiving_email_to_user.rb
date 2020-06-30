class AddReceivingEmailToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :receiving_email, :bool, null: false, default: true
  end
end
