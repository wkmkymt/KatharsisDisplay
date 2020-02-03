class User < ApplicationRecord
  # Attribute
  enum  role:  { user: 0, admin: 1 }

  # Checkin -> Shop
  has_many :checkin, dependent: :delete_all
  has_many :shop, through: :checkin

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
    reviewing.include?(other_user)
  end

  # Checkin / Out
  def checkio(shop_id)
    checkin.create(user_id: self.id, shop_id: shop_id)
    update_attribute(:check_in, !self.check_in)
  end
end
