class Review < ApplicationRecord
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewed, class_name: "User"

  validates :reviewer_id, presence: true
  validates :reviewed_id, presence: true
end
