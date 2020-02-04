class Checkin < ApplicationRecord
  # Attribute
  enum  check_in:  { out: false, in: true }

  belongs_to :user
  belongs_to :shop
end
