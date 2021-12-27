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

  private
    # Authorize
    def authorize_staff
      authorize User
    end

end
