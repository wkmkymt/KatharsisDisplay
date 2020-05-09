class AddEmailToAdvertisement < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :email, :string, null: false
  end
end
