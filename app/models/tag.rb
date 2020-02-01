class Tag < ApplicationRecord
  has_many :interest, dependent: :delete_all
  has_many :user, through: :interest
end
