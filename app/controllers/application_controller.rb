class ApplicationController < ActionController::Base
  # Pundit
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      added_attrs = [ :name, :organization, :profile, :comment, :birthday, :gender, :personality, :color_id, :shop_id, :profimg, tag_ids: [] ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    # Authenticate Admin User
    def authenticate_admin_user!
      authenticate_user!

      unless current_user.has_role? :admin
        raise SecurityError
      end
    end

    # Security Error for Admin
    rescue_from SecurityError do |exception|
      flash[:danger] = "管理者画面へのアクセス権限がありません！"
      redirect_to root_path
    end
end
