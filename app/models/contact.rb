class Contact < ApplicationRecord
  # Validation
  validates :name, presence: true, length: { maximum: 24 }
  validates :email, presence: true
  validates :message, presence: true, length: { maximum: 600 }
end
