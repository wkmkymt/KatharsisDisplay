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

  # Security Error for Admin
  rescue_from SecurityError do |exception|
    redirect_to root_path, notice: '管理者画面へのアクセス権限がありません！'
  end

  protected

  def authenticate_admin_user!
    authenticate_user!

    raise SecurityError unless current_user.has_role? :admin
  end
end
