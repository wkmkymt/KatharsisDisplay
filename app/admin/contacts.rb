ActiveAdmin.register Contact do
  # Permit
  permit_params :name, :email, :message
end
