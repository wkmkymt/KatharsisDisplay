class Shop < ApplicationRecord
  # CheckinRecord -> User
  has_many :checkin_record, dependent: :delete_all
  has_many :checkined_user, through: :checkin_record, source: :user

  # My User
  has_many :user

  # Get Users Checked In
  def get_checkin_users
    checkined_user.joins(:checkin_record).where('checkin_records.check_in', 'in').uniq
  end
end
