class AppController < ApplicationController
  def index
  end

  def tos
    render layout: 'another_window'
  end
end