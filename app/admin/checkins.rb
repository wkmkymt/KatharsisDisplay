ActiveAdmin.register CheckinRecord do
  # Permit
  permit_params :user_id, :shop_id, :check_in
end
