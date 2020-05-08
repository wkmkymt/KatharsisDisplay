class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Google
  def google_oauth2
    callback_for(:google)
  end

  # Twitter
  def twitter
    callback_for(:twitter)
  end

  # Facebook
  def facebook
    callback_for(:facebook)
  end

  # Callback Base
  def callback_for(provider)
    @omniauth = request.env["omniauth.auth"]
    info = User.find_oauth(@omniauth)
    @user = info[:user]

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      @user.skip_confirmation!
      @user.save
      sign_in(:user, @user)
      redirect_to edit_user_registration_path(@user.id)
    end
  end

  def failure
    redirect_to root_path
  end
end