class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

    def after_confirmation_path_for(resource_name, resource)
      sign_in(:user, resource)
      root_path
    end
end
