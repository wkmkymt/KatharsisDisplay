class Contact < ApplicationRecord
  # Validation
  validates :name, presence: true, length: { maximum: 16 }
  validates :email, presence: true
  validates :message, presence: true, length: { maximum: 200 }
end
