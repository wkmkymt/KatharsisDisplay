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

end
