class ContactsController < ApplicationController
  def show
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:success] = "お問い合わせを受け付けました"
      redirect_to root_path
    else
      render :show
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
