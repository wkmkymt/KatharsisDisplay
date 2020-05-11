class DisplaysController < ApplicationController
  # Authentication
  before_action :authorize_staff

  # Display
  def show
    shop = Shop.find(params[:id])
    users = shop.get_checkin_users

    @panels = get_panel(users, shop.get_ads_within_period)

    users.map { |user| user.profimg = "" }
    DisplayChannel.broadcast_to("master", users)

    render layout: "display"
  end

  private
    # Authorize Staff
    def authorize_staff
      authorize User
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
          panels = get_ordered_slides(users, ads)
        else
          panels = get_ordered_slides(ads, users)
        end
      else
        panels = users + ads
      end

      return panels
    end

    # Get Ordered Slide
    def get_ordered_slides(bases, items)
      step = bases.size / items.size

      items.each.with_index do |item, index|
        bases.insert(step * (index + 1) + index, item)
      end

      return bases
    end
end