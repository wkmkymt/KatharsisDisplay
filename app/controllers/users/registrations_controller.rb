# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def update
    if params[:user][:profimg]
      params[:user][:profimg] = params[:user][:profimg].read
    end

    super
  end
end
