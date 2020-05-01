class AppController < ApplicationController
  def index
    @shops = Shop.all
  end

  def tos
    render layout: 'another_window'
  end
end