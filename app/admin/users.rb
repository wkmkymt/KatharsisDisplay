ActiveAdmin.register User do
  # Permit
  permit_params :name, :email, :password, :organization, :comment, :point, :gender, :personality, :birthday, :profimg, :color_id, :shop_id, :confirmed_at, role_ids: [], tag_ids: []

  # Controller
  controller do
    def create
      if permitted_params[:user][:profimg]
        params[:user][:profimg] = permitted_params[:user][:profimg].read
      end

      params[:user][:confirmed_at] = Time.now

      super
    end

    def update
      @user = User.find(params[:id])

      if permitted_params[:user][:profimg]
        params[:user][:profimg] = permitted_params[:user][:profimg].read
      end

      if permitted_params[:user][:password].blank?
        @user.update_without_password(permitted_params[:user])
      else
        @user.update_attributes(permitted_params[:user])
      end

      if @user.errors.blank?
        redirect_to admin_users_path, :success => "ユーザの更新が完了しました"
      else
        render :edt
      end
    end
  end

  # Index
  index do
    selectable_column
    column :id
    column :name
    column :gender
    column :personality
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
    column :shop
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
      row :personality
      row :birthday
      row :email
      row :organization
      row :color
      row :comment
      row :roles
      row :point
      row :shop
      row 'Checkin' do |user|
        user.check_in?
      end
      row :created_at
      row :updated_at
    end

    panel "Profile Image" do
      image_tag user_image_path(user.id)
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
      f.input :password
      f.input :gender
      f.input :personality
      f.input :birthday
      f.input :organization
      f.input :comment
      f.file_field :profimg, accept: "image/jpg, image/jpeg, image/png, image/gif"
      f.input :color
      f.collection_check_boxes :tag_ids, Tag.all, :id, :name do |t|
        t.check_box + t.text
      end
      f.input :roles
      f.input :shop
      f.input :point
    end
    f.actions
  end
end
