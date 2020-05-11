class AdvertisementsController < ApplicationController
  # Authentication
  before_action :authorize_staff

  # Index
  def index
    @ad = Advertisement.new
  end

  # Create
  def create
    if params[:advertisement][:adimg]
      params[:advertisement][:adimg] = params[:advertisement][:adimg].read
    end

    @ad = Advertisement.new(advertisement_params)

    if @ad.save
      flash[:success] = "広告の登録を受け付けました"
      redirect_to root_path
    else
      render :new
    end
  end

  # Show Image
  def show_image
    @ad = Advertisement.find(params[:advertisement_id])
    send_data(@ad.adimg)
  end

  private
    # Authorize
    def authorize_staff
      authorize User
    end

    # Params
    def advertisement_params
      params.require(:advertisement).permit(:sponsor, :email, :adimg, :url, :start_date, :end_date, { placed_shop_ids: [] })
    end
end