class UsersController < ApplicationController
  # Profile
  def show
     @user = User.find(params[:user_id])

     @review = Review.new
  end

  # Check In
  def checkin
    current_user.checkin(1)
    redirect_to root_path
  end

  # Check Out
  def checkout
    current_user.checkout
    redirect_to root_path
  end
end
