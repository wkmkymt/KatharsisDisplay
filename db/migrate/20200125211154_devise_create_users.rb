class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      # Base
      t.string :name,               null: false
      t.string :email,              null: false
      t.string :encrypted_password, null: false
      t.string :organization
      t.text   :profile

      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Timestamp
      t.timestamps null: false
    end

    # Add Index
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
