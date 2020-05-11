module DeviseManager
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
      added_attrs = [ :name, :organization, :profile, :comment, :birthday, :gender, :personality, :color_id, :shop_id, :profimg, tag_ids: [] ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
  end
end