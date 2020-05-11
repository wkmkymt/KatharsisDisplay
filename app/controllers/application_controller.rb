class ApplicationController < ActionController::Base
  # Include
  include CommonError
  include DeviseManager
  include AdminUserAuthentication
  include UserRolePolicy

  # Authentication
  before_action :authenticate_user!
end
