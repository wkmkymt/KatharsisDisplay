class AdvertisementsController < ApplicationController
  # New
  def new
    @ad = Advertisement.new
  end

  # Create
  def create
    @ad = Advertisement.new(advertisement_params)

    if @ad.save
      flash[:success] = "広告の登録を受け付けました"
      redirect_to root_path
    else
      render :new
    end
  end

  # Advertisement Image
  def show_adimg
    @ad = Advertisement.find(params[:ad_id])
    send_data(@ad.adimg)
  end

  private

    def advertisement_params
      params.require(:advertisement).permit(:sponsor, :email, :adimg, :url, :start_date, :end_date, { placed_shop_ids: [] })
    end
end