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
    shop = Shop.find(params[:shop_id])
    users = shop.get_checkin_users

    @panels = get_panel(users, shop.advertisement)

    users.map { |user| user.profimg = "" }
    DisplayChannel.broadcast_to('master', users)

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
    @user = User.find(params[:user_id])

    if @user.check_in?
      @user.checkout
      DisplayChannel.broadcast_to('master',
        code: 'checkout',
        user: {
          id: @user.id,
        },
      )
      flash[:success] = "#{@user.name}が「#{current_user.shop.name}」をチェックアウトしました"
    else
      flash[:danger] = "#{@user.name}は事前に「#{current_user.shop.name}」にチェックインしていません"
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
    flash[:success] = "#{current_user.shop.name}: 全員チェックアウトしました"
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
      flash[:danger] = "許可されていないアカウントです"
      redirect_to request.referrer || root_path
    end

    # Get Panel
    def get_panel(users_a, ads_a)
      users = []
      users_a.each do |user|
        users.push({ type: "user", body: user })
      end

      ads = []
      ads_a.each do |ad|
        ads.push({ type: "ad", body: ad })
      end

      panels = []
      if users.present? and ads.present?
        if users.size >= ads.size
          panels = set_panel_order(users, ads)
        else
          panels = set_panel_order(ads, users)
        end
      else
        panels = users + ads
      end

      return panels
    end

    # Set Item Alternate
    def set_panel_order(bases, items)
      step = bases.size / items.size

      items.each.with_index do |item, index|
        bases.insert(step * (index + 1) + index, item)
      end

      return bases
    end
end
