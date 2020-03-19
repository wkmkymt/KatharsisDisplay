class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:checkin, :checkout]
  before_action :authorize_staff, only: [:checkin, :checkout]

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

  private
    # Authorize
    def authorize_staff
      authorize User
    end
end
