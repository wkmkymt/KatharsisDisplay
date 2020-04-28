# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if params[:user][:profimg_temp]
      b64 = params[:user][:profimg_temp]
      bin = Base64.decode64(b64)
      file = Tempfile.new('img', :encoding => 'utf8')
      file.binmode
      file << bin
      file.rewind
      params[:user][:profimg] = file.read
    end

    super
  end

  def update
    if params[:user][:profimg_temp]
      b64 = params[:user][:profimg_temp]
      bin = Base64.decode64(b64)
      file = Tempfile.new('img', :encoding => 'utf8')
      file.binmode
      file << bin
      file.rewind
      params[:user][:profimg] = file.read
    end

    super
  end

  protected

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

end
