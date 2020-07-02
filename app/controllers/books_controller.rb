class BooksController < ApplicationController
  require 'RMagick'
  
  # Authentication
  before_action :authorize_staff

  # Index
  def index
    @book = Book.new
  end

  # Create
  def create

    if params[:book][:book_file]
      file = params[:book][:book_file]
      pdf = Magick::ImageList.new(file.path + '[0]') #=> 1ページ目のみ抽出
      cover_tmp = Rails.root.join('public', file.original_filename)
      pdf[0].write(cover_tmp)
    end

    @book = Book.new(book_params)

    if @book.save
      flash[:success] = "デジタルコンテンツの登録を受け付けました"
      redirect_to root_path
    else
      render :index
    end
  end


  private
    # Authorize
    def authorize_staff
      authorize User
    end

    # Params
    def book_params
      params.require(:book).permit(:name, :author, :abstract, :required_point)
    end
end