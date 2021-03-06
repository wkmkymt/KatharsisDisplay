class Shop < ApplicationRecord
  # CheckinRecord -> User
  has_many :checkin_record, dependent: :delete_all
  has_many :checkined_user, through: :checkin_record, source: :user

  # AdContract -> Advertisement
  has_many :ad_contract, dependent: :delete_all
  has_many :advertisement, through: :ad_contract

  # My User
  has_many :user

  # Get Users Checked In
  def get_checkin_users(user_id=nil)
    users = checkined_user.joins(:checkin_record).where('checkin_records.check_in', 'in').order('checkin_records.created_at DESC').uniq
    if user_id
      users.select{ |user| user[:id] == user_id } + users.select{ |user| user[:id] != user_id }
    else
      users
    end
  end

  # Get Users My Shoped
  def get_myshoped_users
    user.joins(:roles).where(roles: {name: "guest"})
  end

  # Get Staffs
  def get_staffs
    user.joins(:roles).where(roles: {name: "staff"})
  end

  # Get Advertisements within publication period
  def get_ads_within_period
    advertisement.where("start_date <= ? and end_date >= ?", Date.today, Date.today)
  end
end
