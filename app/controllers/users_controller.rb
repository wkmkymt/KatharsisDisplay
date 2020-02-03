class UsersController < ApplicationController
  def show
     @user = User.find(params[:user_id])
  end

  def checkio
    current_user.checkio(1)
    redirect_to root_path
  end
end
