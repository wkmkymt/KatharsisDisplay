class Shop < ApplicationRecord
  has_many :checkin_record, dependent: :delete_all
  has_many :user, through: :checkin_record

  # Get Users Checked In
  def get_checkin_users
    checkin_record.where(check_in: 'in').joins(:user).select("users.*")
  end
end
