class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

    def after_confirmation_path_for(resource_name, resource)
      sign_in(:user, resource)
      edit_user_registration_path
    end
end
