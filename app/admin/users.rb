ActiveAdmin.register User do
  # Permit
  permit_params :name, :email, :organization, :comment, :point, :gender, :birthday, :profimg, :color_id, role_ids: [], tag_ids: []

  # Controller
  controller do
    def update
      @user = User.find(params[:id])
      @user.update(permitted_params[:user])

      if permitted_params[:user][:profimg]
        @user.profimg = permitted_params[:user][:profimg].read
      end

      if @user.save
        redirect_to admin_user_path(@user.id)
      end
    end
  end

  # Index
  index do
    selectable_column
    column :id
    column :name
    column :gender
    column :birthday
    column :email
    column :organization
    column 'Tags' do |user|
      user.tag.each do |tag|
        tag.name
      end
    end
    column :color
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
      row :gender
      row :birthday
      row :email
      row :organization
      row :color
      row :comment
      row :roles
      row :point
      row 'Checkin' do |user|
        user.check_in?
      end
      row :created_at
      row :updated_at
    end

    panel "Profile Image" do
      image_tag show_profimg_user_path(user.id)
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
      f.input :gender
      f.input :birthday
      f.input :email
      f.input :organization
      f.input :comment
      f.file_field :profimg, accept: "image/jpeg"
      f.input :color
      f.collection_check_boxes :tag_ids, Tag.all, :id, :name do |t|
        t.check_box + t.text
      end
      f.input :roles
      f.input :point
    end
    f.actions
  end
end
