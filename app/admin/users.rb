ActiveAdmin.register User do
  # Permit
  permit_params :name, :email, :password, :organization, :comment, :point, :gender, :personality, :birthday, :profimg, :color_id, :shop_id, :confirmed_at, role_ids: [], tag_ids: []

  collection_action :download_users, method: :get do
    csv_data = CSV.generate do |csv|
      csv << [
        "id", "name", "email", "organization", "comment", "point",
        "gender", "personality", "birthday", "color_id", "shop_id"
      ]
      User.find_each(batch_size: 500) do |user|
        csv << [
          user.id, user.name, user.email, user.organization, user.comment, user.point,
          user.gender, user.personality, user.birthday, user.color_id, user.shop_id
        ]
      end
    end
    send_data csv_data, type: 'text/csv; header=present', disposition: 'attachment; filename=users.csv'
  end

  action_item only: :index do
    link_to "Export CSV", {:controller => "admin/users", action: :download_users}
  end

  # Controller
  controller do
    def create
      if permitted_params[:user][:profimg]
        file = permitted_params[:user][:profimg]
      else
        file = File.open("./app/assets/images/noavatar.png", "r")
      end
      params[:user][:profimg] = file.read

      params[:user][:confirmed_at] = Time.now

      super
    end

    def update
      @user = User.find(params[:id])

      if permitted_params[:user][:profimg]
        params[:user][:profimg] = permitted_params[:user][:profimg].read
      end

      @user.skip_reconfirmation!

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
  index download_links: false do
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
