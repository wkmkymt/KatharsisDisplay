class OperationsController < ApplicationController
  # Authentication
  before_action :authorize_staff

  def ads_list
    if current_user.has_role? :admin
      @advertisements = Advertisement.where("start_date <= ? and end_date >= ?", Date.today, Date.today)
    elsif current_user.has_role? :staff
      shop  = Shop.find_by(id: current_user.shop)
      @advertisements = shop.get_ads_within_period
    end
  end

  def users_list
    pager_per = 20
    if current_user.has_role? :admin
      @users = User.joins(:roles).where("roles.name = ?", :guest).page(params[:page]).per(pager_per).order(id: "DESC")
    elsif current_user.has_role? :staff
      @users = User.joins(:roles).where("shop_id = ? and roles.name = ?", current_user.shop_id, :guest).page(params[:page]).per(pager_per).order(id: "DESC")
    end
  end

  private
    # Authorize
    def authorize_staff
      authorize User
    end

end
