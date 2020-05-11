class UserPolicy < ApplicationPolicy
  def index?
    user.has_role? :admin or user.has_role? :staff
  end

  def show?
    user.has_role? :admin or user.has_role? :staff
  end

  def create?
    user.has_role? :admin or user.has_role? :staff
  end

  def destroy?
    user.has_role? :admin or user.has_role? :staff or user.id == record.id
  end

  def show_image?
    user.has_role? :admin or user.has_role? :staff
  end

  def checkin?
    user.has_role? :admin or user.has_role? :staff
  end

  def checkout?
    user.has_role? :admin or user.has_role? :staff
  end

  def checkout_all?
    user.has_role? :admin or user.has_role? :staff
  end
end