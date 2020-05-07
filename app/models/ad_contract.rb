class AdContract < ApplicationRecord
  # Advertisement <-> Shop
  belongs_to :advertisement
  belongs_to :shop
end
