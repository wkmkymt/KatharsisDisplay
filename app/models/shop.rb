class Shop < ApplicationRecord
  has_many :checkin_record, dependent: :delete_all
  has_many :user, through: :checkin_record

  # Get Users Checked In
  def get_checkin_users
    user.joins(:checkin_record).where('checkin_records.check_in', 'in').uniq
  end
end
