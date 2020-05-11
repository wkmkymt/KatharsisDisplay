class Advertisement < ApplicationRecord
  # Validation
  validates :sponsor, presence: true, length: { maximum: 16 }
  validates :email, presence: true
  validates :adimg, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :placed_shop, presence: true
  validates_with StartDateValidator
  validates_with EndDateValidator

  # AdContract -> Shop
  has_many :ad_contract, dependent: :delete_all
  has_many :placed_shop, through: :ad_contract, source: :shop

  # Nest Create
  accepts_nested_attributes_for :ad_contract, allow_destroy: true
end
