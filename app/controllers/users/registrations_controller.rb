# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def update
    if params[:user][:profimg]
      params[:user][:profimg] = params[:user][:profimg].read
    end

    super
  end

  protected

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end
end
