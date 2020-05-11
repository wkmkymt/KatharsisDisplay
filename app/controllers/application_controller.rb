class ApplicationController < ActionController::Base
  # Authentication
  before_action :authenticate_user!

  include CommonError
  include DeviseManager
  include AdminUserAuthentication
  include UserRolePolicy
end
