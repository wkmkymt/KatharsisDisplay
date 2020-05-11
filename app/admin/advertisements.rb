ActiveAdmin.register Advertisement do
  # Permit
  permit_params :sponsor, :email, :adimg, :url, :start_date, :end_date, ad_contract_attributes: [:shop_id, :_destroy, :id]

  # Controller
  controller do
    def create
      if permitted_params[:advertisement][:adimg]
        params[:advertisement][:adimg] = permitted_params[:advertisement][:adimg].read
      end

      super
    end

    def update
      if permitted_params[:advertisement][:adimg]
        params[:advertisement][:adimg] = permitted_params[:advertisement][:adimg].read
      end

      super
    end
  end

  # Index
  index do
    selectable_column
    column :id
    column :sponsor
    column :email
    column :url
    column :placed_shop
    column :start_date
    column :end_date
    column :created_at
    column :updated_at
    actions
  end

  # Show
  show do |ad|
    attributes_table do
      row :id
      row :sponsor
      row :email
      row :url
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end

    panel "Advertisement Image" do
      image_tag advertisement_image_path(ad.id)
    end

    panel "Shops" do
      table_for ad.placed_shop do
        column :name do |shop|
          link_to shop.name, admin_shop_path(shop)
        end
      end
    end
  end

  # Form
  form do |f|
    f.inputs do
      f.input :sponsor
      f.input :email
      f.input :url
      f.has_many :ad_contract, allow_destroy: true, new_record: true, heading: "掲載先" do |t|
        t.input :shop
      end
      f.input :start_date
      f.input :end_date
      f.file_field :adimg, accept: "image/jpg, image/jpeg, image/png, image/gif"
    end
    f.actions
  end

end
