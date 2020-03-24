class Photo < ApplicationRecord
  belongs_to :user

  # Uploader
  mount_uploader :image, ImageUploader
end
