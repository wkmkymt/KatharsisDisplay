class CheckinRecord < ApplicationRecord
  # Attribute
  enum  check_in:  { out: false, in: true }

  # User <-> Shop
  belongs_to :user
  belongs_to :shop

  # Check Out
  def checkout
    update_attributes(check_in: 'out')
  end
end
