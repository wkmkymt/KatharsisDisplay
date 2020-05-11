class CheckinsController < ApplicationController
  # Authentication
  before_action :authorize_staff

  # Check In
  def checkin
    @user = User.find(params[:id])

    unless @user.check_in?
      if @current_user.shop
        @user.checkin(current_user.shop.id)
        broadcast_checkin @user

        if @user.shop.id == current_user.shop.id
          flash[:success] = "#{@user.name}が「#{current_user.shop.name}」にチェックインしました"
        else
          flash[:success] = "#{@user.name}が「#{current_user.shop.name}」にチェックインしました<br />マイショップ設定「#{@user.shop.name}」のユーザです"
        end
      else
        flash[:danger] = "マイショップが指定されていません"
      end
    else
      flash[:danger] = "#{@user.name}は既に「#{@user.get_checkin_shop.name}」にチェックイン済みです"
    end

    redirect_to root_path
  end

  # Check Out
  def checkout
    @user = User.find(params[:id])

    if @user.check_in?
      @user.checkout
      broadcast_checkout @user

      flash[:success] = "#{@user.name}が「#{current_user.shop.name}」をチェックアウトしました"
    else
      flash[:danger] = "#{@user.name}は事前に「#{current_user.shop.name}」にチェックインしていません"
    end

    redirect_to root_path
  end

  # Check Out All
  def checkout_all
    current_user.shop.get_checkin_users.each do |user|
      if user.check_in?
        user.checkout
        broadcast_checkout user
      end
    end
    flash[:success] = "#{current_user.shop.name}: 全員チェックアウトしました"

    redirect_to root_path
  end

  private
    # Authorize Staff
    def authorize_staff
      authorize User
    end

    # Broadcast Checkin
    def broadcast_checkin user
      DisplayChannel.broadcast_to('master',
        code: 'checkin',
        user: {
          type: "user",
          body: {
            id: user.id,
            name: user.name,
            organization: user.organization,
            comment: user.comment,
            color: user.color.name,
            tags: user.tag.map{ |tag| tag.name },
          },
        },
      )
    end

    # Broadcast Checkout
    def broadcast_checkout user
      DisplayChannel.broadcast_to('master',
        code: 'checkout',
        user: {
          id: user.id,
        },
      )
    end
end