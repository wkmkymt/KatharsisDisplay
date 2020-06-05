class UsersController < ApplicationController
  # Show
  def show
    @user = User.find(params[:id])
  end

  # Destroy
  def destroy
    @user = User.find(params[:id])
    user_name = @user.name

    # Authentication
    authorize @user

    if @user.destroy
      flash[:success] = "#{user_name}: 退会処理が完了しました"
    else
      flash[:danger] = "#{user_name}: 退会処理に失敗しました"
    end

    redirect_to root_path
  end

  # Destroy Confirmation
  def destroy_confirmation
  end

  # Show Image
  def show_image
    profimg = User.find(params[:user_id]).profimg
    send_data(profimg)
  end
end
