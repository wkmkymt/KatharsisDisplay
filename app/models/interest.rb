class Interest < ApplicationRecord
  # User <-> Tag
  belongs_to :user
  belongs_to :tag
end
