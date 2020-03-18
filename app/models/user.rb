class User < ApplicationRecord
  # Rollify
  rolify

  # CheckinRecord -> Shop
  has_many :checkin_record, dependent: :delete_all
  has_many :shop, through: :checkin_record

  # Interest -> Tag
  has_many :interest, dependent: :delete_all
  has_many :tag, through: :interest

  # Reviewings
  has_many :reviewing_relationships, class_name:  "Review",
                                     foreign_key: "reviewer_id",
                                     dependent:   :destroy
  has_many :reviewings, through: :reviewing_relationships, source: :reviewed

  # Reviewers
  has_many :reviewer_relationships, class_name:  "Review",
                                    foreign_key: "reviewed_id",
                                    dependent:   :destroy
  has_many :reviewers, through: :reviewer_relationships, source: :reviewer

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:guest) if self.roles.blank?
  end

  # Review
  def review(other_user, rate, comment: "")
    unless self == other_user
      reviewing_relationships.create(reviewed_id: other_user.id, rate: rate, comment: comment)
    end
  end

  # Unreview
  def unreview(other_user)
    reviewing_relationships.find_by(reviewed_id: other_user.id).destroy
  end

  # Is Reviewing?
  def reviewing?(other_user)
    reviewings.include?(other_user)
  end

  # Get Record Checked In
  def get_checkin_record
    checkin_record.where(check_in: 'in').first
  end

  # Get Shop Checked In
  def get_checkin_shop
    get_checkin_record.shop
  end

  # Check In?
  def check_in?
    get_checkin_record ? true : false
  end

  # Check In
  def checkin(shop_id)
    unless check_in?
      checkin_record.create(user_id: self.id, shop_id: shop_id)
      self.point += 1
      self.save
    end
  end

  # Check Out
  def checkout
    if check_in?
      get_checkin_record.checkout
    end
  end
end
