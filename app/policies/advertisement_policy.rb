class AdvertisementPolicy < ApplicationPolicy
  def new?
    user.has_role? :admin or user.has_role? :staff
  end

  def create?
    user.has_role? :admin or user.has_role? :staff
  end
end