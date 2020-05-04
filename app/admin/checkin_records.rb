ActiveAdmin.register CheckinRecord do
  # Permit
  permit_params :user_id, :shop_id, :check_in

  # Form
  form do |f|
    f.inputs do
      f.input :user_id
      f.input :shop_id
      f.input :check_in, as: :select
    end
    f.actions
  end
end
