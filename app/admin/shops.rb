ActiveAdmin.register Shop do
  # Permit
  permit_params :name, :address, :description, :checkin_point

  # Show
  show do |shop|
    attributes_table do
      row :id
      row :name
      row :address
      row :description
      row :checkin_point
      row :created_at
      row :updated_at
    end

    panel "Checkin Users" do
      table_for shop.get_checkin_users do
        column :name do |user|
          link_to user.name, admin_user_path(user)
        end
      end
    end

    panel "Staffs" do
      table_for shop.get_staffs do
        column :name do |user|
          link_to user.name, admin_user_path(user)
        end
      end
    end

    panel "My Shoped Users" do
      table_for shop.get_myshoped_users do
        column :name do |user|
          link_to user.name, admin_user_path(user)
        end
      end
    end

    panel "Advertisements" do
      table_for shop.advertisement do
        column :name do |ad|
          link_to ad.sponsor, admin_advertisement_path(ad)
        end
      end
    end
  end
end
