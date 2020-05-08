class CreateAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.string :sponsor, null: false
      t.binary :adimg, null: false
      t.string :url
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
