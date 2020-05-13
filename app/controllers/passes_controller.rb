class PassesController < ApplicationController
  def edit
    @user = User.new
  end

  def update
    @user = current_user

    if params[:user][:current_password].present?
      if @user.valid_password?(params[:user][:current_password])
        @user.assign_attributes(password_params)
        if @user.save
          sign_in(:user, @user, bypass: true)
          flash[:success] = "パスワードを変更しました"
          redirect_to root_path
        else
          render :edit
        end
      else
        @user.errors.add(:current_password, :wrong)
        render :edit
      end
    else
      @user.errors.add(:current_password, :blank)
      render :edit
    end
  end

  private
    # Params
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end