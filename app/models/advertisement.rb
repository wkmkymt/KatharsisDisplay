class Advertisement < ApplicationRecord
  # AdContract -> Shop
  has_many :ad_contract, dependent: :delete_all
  has_many :placed_shop, through: :ad_contract, source: :shop
end
