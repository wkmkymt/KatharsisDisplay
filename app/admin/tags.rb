ActiveAdmin.register Tag do
  # Permit
  permit_params :name, :category_id

  # Index
  index do
    selectable_column
    column :id
    column :name
    column :category
    column :created_at
    column :updated_at
    actions
  end
end
