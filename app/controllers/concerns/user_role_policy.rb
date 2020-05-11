module UserRolePolicy
  extend ActiveSupport::Concern

  included do
    # Policy
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    # Not Authorized
    def not_authorized
      flash[:danger] = "許可されていないアカウントです"
      redirect_to request.referrer || root_path
    end
  end
end