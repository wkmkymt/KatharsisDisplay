ActiveAdmin.register Photo do
  # Permit
  permit_params :image, :user_id

  # Index
  index do
    selectable_column
    column :id
    column :image do |photo|
      image_tag photo.image.thumb.url
    end
    column :user_id
    actions
  end

  # Show
  show do |photo|
    attributes_table do
      row :image do
        image_tag photo.image.url
      end
      row :user_id
    end
  end

  # Form
  form do |f|
    f.inputs do
      f.input :image, :as => :file
      f.input :user_id
    end
    f.actions
  end


end
