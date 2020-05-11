module AdminUserAuthentication
  extend ActiveSupport::Concern

  included do
    # Security Error for Admin
    rescue_from SecurityError do |exception|
      flash[:danger] = "管理者画面へのアクセス権限がありません！"
      redirect_to root_path
    end

    # Authenticate Admin User
    def authenticate_admin_user!
      authenticate_user!

      unless current_user.has_role? :admin
        raise SecurityError
      end
    end
  end
end