class UsersController < ApplicationController
  # Profile
  def show
     @user = User.find(params[:user_id])

     @review = Review.new
  end

  # Check In
  def checkin
    User.find(params[:user_id]).checkin(1)
    redirect_to root_path
  end

  # Check Out
  def checkout
    User.find(params[:user_id]).checkout
    redirect_to root_path
  end
end
