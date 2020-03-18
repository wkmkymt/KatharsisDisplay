ActiveAdmin.register User do
  # Permit
  permit_params :name, :email, :organization, :comment, :role, :point

  # Index
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :organization
    column 'Tags' do |user|
      user.tag.each do |tag|
        tag.name
      end
    end
    column :comment
    column :roles
    column :point
    column 'Checkin' do |user|
      user.check_in?
    end
    column :created_at
    column :updated_at
    actions
  end

  # Show
  show do |user|
    attributes_table do
      row :id
      row :name
      row :email
      row :organization
      row :comment
      row :roles
      row :point
      row 'Checkin' do |user|
        user.check_in?
      end
      row :created_at
      row :updated_at
    end

    panel "Tags" do
      table_for user.tag do
        column :name do |tag|
          link_to tag.name, admin_tag_path(tag)
        end
      end
    end

    panel "Reviews" do
      table_for user.reviewer_relationships do
        column :reviewer do |review|
          link_to review.reviewer.name, admin_user_path(review.reviewer)
        end
        column :rate
        column :comment
      end
    end

  end

  # Form
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :organization
      f.input :comment
      f.input :roles
      f.input :point
    end
    f.actions
  end
end
