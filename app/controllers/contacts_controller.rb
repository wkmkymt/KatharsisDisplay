class ContactsController < ApplicationController
  # Not Authentication
  skip_before_action :authenticate_user!

  # Show
  def show
    @contact = Contact.new
  end

  # Create
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.contact_mail(@contact).deliver

      flash[:success] = "お問い合わせを受け付けました"
      redirect_to root_path
    else
      render :show
    end
  end

  private
    # Params
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
