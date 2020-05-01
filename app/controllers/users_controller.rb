class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:checkin, :checkout, :destroy, :destroy_confirmation]
  before_action :authorize_staff, only: [:checkin, :checkout, :display]

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
    @users = Shop.find(params[:shop_id]).get_checkin_users
    @users.map { |user| user.profimg = "" }

    DisplayChannel.broadcast_to('master', @users)

    render layout: 'display'
  end

  # Check In
  def checkin
    @user = User.find(params[:user_id])

    unless @user.check_in?
      if @current_user.shop
        @user.checkin(current_user.shop.id)
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
        flash[:success] = "#{@user.name}: チェックインに成功しました"
      else
        flash[:danger] = "マイショップが指定されていません"
      end
    else
      flash[:danger] = "#{@user.name}: 既にチェックイン済みです"
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
      flash[:success] = "#{@user.name}: チェックアウトしました"
    else
      flash[:danger] = "#{@user.name}: 事前にチェックインしていません"
    end

    redirect_to root_path
  end

  def checkout_all
    current_user.shop.get_checkin_users.each do |user|
      if user.check_in?
        user.checkout
        DisplayChannel.broadcast_to('master',
          code: 'checkout',
          user: {
            id: user.id,
          },
        )
      end
    end
    @shop = Shop.find_by(id:current_user.shop)
    flash[:success] = "#{@shop.name}: 全員チェックアウトしました"
    redirect_to root_path
  end

  def destroy_confirmation
  end

  def destroy
    @user = current_user
    temp = "#{@user.name}"
    @user.destroy
    redirect_to root_path
    flash[:success] = "#{temp}: 退会処理が完了しました"
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
