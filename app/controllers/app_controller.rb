class AppController < ApplicationController
  before_action :login_check, only: [:destroy_confirmation]

  def index
  end

  def tos
    render layout: 'another_window'
  end

  def destroy_confirmation
  end

  def login_check
    unless user_signed_in?
      flash[:alert] = "ログインしていません"
      redirect_to root_path
      end
    end
end