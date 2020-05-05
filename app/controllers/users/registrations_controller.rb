class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if params[:user][:profimg_temp]
      file = trans_file(params[:user][:profimg_temp])
      params[:user][:profimg] = file.read
    end

    super

    # Add Default Role
    if resource.roles.blank?
      resource.add_role :guest
    end
  end

  def update
    if params[:user][:profimg_temp]
      file = trans_file(params[:user][:profimg_temp])
      params[:user][:profimg] = file.read
    end

    super
  end

  protected

    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

    def trans_file(file)
      bin = Base64.decode64(file)
      file = Tempfile.new('img', :encoding => 'utf8')
      file.binmode
      file << bin
      file.rewind

      return file
    end

end
