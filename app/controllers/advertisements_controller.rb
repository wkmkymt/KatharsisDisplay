class AdvertisementsController < ApplicationController
  before_action :authorize_staff, only: [:new, :create]

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  # New
  def new
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

  # Advertisement Image
  def show_adimg
    @ad = Advertisement.find(params[:ad_id])
    send_data(@ad.adimg)
  end

  private
    # Authorize
    def authorize_staff
      authorize Advertisement
    end

    # Not Authorized
    def not_authorized
      flash[:danger] = "許可されていないアカウントです"
      redirect_to root_path
    end

    def advertisement_params
      params.require(:advertisement).permit(:sponsor, :email, :adimg, :url, :start_date, :end_date, { placed_shop_ids: [] })
    end
end