class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:checkin, :checkout]
  before_action :authorize_staff, only: [:checkin, :checkout]

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  # Profile
  def show
     @user = User.find(params[:user_id])

     @review = Review.new
  end

  # Profile Image
  def show_profimg
    @user = User.find(params[:id])
    send_data(@user.profimg)
  end

  # Display
  def display
    @users = Shop.find(1).get_checkin_users
    @users.map { |user| user.profimg = "" }

    DisplayChannel.broadcast_to('master', @users)

    render layout: 'display'
  end

  # Check In
  def checkin
    @user = User.find(params[:user_id])

    unless @user.check_in?
      @user.checkin(1)
      DisplayChannel.broadcast_to('master',
        code: 'checkin',
        user: {
          id: @user.id,
          name: @user.name,
          organization: @user.organization,
          comment: @user.comment,
          color: @user.color.name,
          tags: @user.tag,
        },
      )
      flash[:success] = "#{@user.name} have just checked in!"
    else
      flash[:danger] = "#{@user.name} have already checked in..."
    end

    redirect_to root_path
  end

  # Check Out
  def checkout
    @user = User.find(params[:user_id])

    if @user.check_in?
      @user.checkout
      DisplayChannel.broadcast_to('master',
        code: 'checkout',
        user: {
          id: @user.id,
        },
      )
      flash[:success] = "#{@user.name} have just checked out!"
    else
      flash[:danger] = "#{@user.name} have not checked in..."
    end

    redirect_to root_path
  end

  private
    # Authorize
    def authorize_staff
      authorize User
    end

    # Not Authorized
    def not_authorized
      flash[:danger] = "You are not allowed!"
      redirect_to request.referrer || root_path
    end
end
