class Tag < ApplicationRecord
  # Interest -> User
  has_many :interest, dependent: :delete_all
  has_many :user, through: :interest

  # Category
  belongs_to :category
end
