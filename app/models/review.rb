class Review < ApplicationRecord
  # Validation
  validates :reviewer_id, presence: true
  validates :reviewed_id, presence: true

  # Reviewer User <-> Reviewed User
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewed, class_name: "User"
end
