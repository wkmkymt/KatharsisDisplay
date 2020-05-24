class PassPolicy < ApplicationPolicy
  def new?
    !user.has_password?
  end

  def create?
    !user.has_password?
  end

  def edit?
    user.has_password?
  end

  def update?
    user.has_password?
  end
end