class AdvertisementsController < ApplicationController
  # Advertisement Image
  def show_adimg
    @ad = Advertisement.find(params[:ad_id])
    send_data(@ad.adimg)
  end
end