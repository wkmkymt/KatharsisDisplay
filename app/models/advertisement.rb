class Advertisement < ApplicationRecord
  # AdContract -> Shop
  has_many :ad_contract, dependent: :delete_all
  has_many :placed_shop, through: :ad_contract, source: :shop

  # Nest Create
  accepts_nested_attributes_for :ad_contract, :allow_destroy => true
end
