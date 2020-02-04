class ChangeCheckinToCheckinRecord < ActiveRecord::Migration[5.2]
  def change
    rename_table :checkins, :checkin_records
  end
end
