# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if params[:user][:profimg]
      params[:user][:profimg] = params[:user][:profimg].read
    end

    super
  end

  def update
    if params[:user][:profimg]
      session[:crop_x] = params[:user][:x]
      session[:crop_y] = params[:user][:y]
      session[:crop_width] = params[:user][:width]
      session[:crop_height] = params[:user][:height]
      params[:user][:profimg] = params[:user][:profimg].read
    end

    super
  end

  protected

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

  private

    def crop
      return
      manipulate! do |img|
        crop_x = params[:user][:x].to_i
        crop_y = params[:user][:y].to_i
        crop_w = params[:user][:width].to_i
        crop_h = params[:user][:height].to_i
        img.crop "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
        img = yield(img) if block_given?
        img
      end
    end

end
