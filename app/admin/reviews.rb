ActiveAdmin.register Review do
  # Permit
  permit_params :reviewer_id, :reviewed_id, :rate, :comment
end
