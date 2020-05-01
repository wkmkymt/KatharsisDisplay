class UserPolicy < ApplicationPolicy
  def display?
    user.has_role? :admin or user.has_role? :staff
  end

  def checkin?
    user.has_role? :admin or user.has_role? :staff
  end

  def checkout?
    user.has_role? :admin or user.has_role? :staff
  end
end