class Shop < ApplicationRecord
  has_many :checkin, dependent: :delete_all
  has_many :user, through: :checkin
end
