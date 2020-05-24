class PassesController < ApplicationController
  # Authentication
  before_action :valid_password

  # New
  def new
    @user = User.new
  end

  # Create
  def create
    @user = current_user

    @user.assign_attributes(password_params)
    if @user.save
      sign_in(:user, @user, bypass: true)
      flash[:success] = "パスワードを登録しました"
      redirect_to root_path
    else
      render :new
    end
  end

  # Edit
  def edit
    @user = User.new
  end

  # Update
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
    # Valid Password?
    def valid_password
      authorize Pass
    end

    # Params
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end