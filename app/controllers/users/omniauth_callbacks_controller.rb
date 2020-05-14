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
    info = User.find_oauth(request.env["omniauth.auth"])

    if info[:new]
      sign_in(:user, info[:user])
      flash[:success] = "アカウントを登録しました。"
      redirect_to edit_user_registration_path(info[:user].id)
    else
      sign_in_and_redirect info[:user], event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    end
  end

  def failure
    redirect_to root_path
  end
end