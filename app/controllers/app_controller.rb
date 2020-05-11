class AppController < ApplicationController
  # Not Authentication
  skip_before_action :authenticate_user!

  # Index
  def index
    @shops = Shop.all
  end

  # Terms of Service
  def tos
    render layout: "another_window"
  end

  # Privacy Policy
  def privacy
    render layout: "another_window"
  end
end