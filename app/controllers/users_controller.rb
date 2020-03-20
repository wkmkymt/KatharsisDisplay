class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:checkin, :checkout]
  before_action :authorize_staff, only: [:checkin, :checkout]

  # Profile
  def show
     @user = User.find(params[:user_id])

     @review = Review.new
  end

  # Display
  def display
    @users = Shop.find(1).get_checkin_users

    DisplayChannel.broadcast_to('master', @users)

    render layout: 'display'
  end

  # Check In
  def checkin
    user = User.find(params[:user_id])

    unless user.check_in?
      user.checkin(1)
      DisplayChannel.broadcast_to('master',
        code: 'checkin',
        user: user,
        tags: user.tag,
      )
    end

    redirect_to root_path
  end

  # Check Out
  def checkout
    user = User.find(params[:user_id])
    user.checkout

    DisplayChannel.broadcast_to('master',
      code: 'checkout',
      userid: user.id,
    )

    redirect_to root_path
  end

  private
    # Authorize
    def authorize_staff
      authorize User
    end
end
