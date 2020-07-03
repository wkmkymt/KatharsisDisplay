class BooksController < ApplicationController
  require 'RMagick'

  # Form
  def form
    @book = Book.new
  end

  # Create
  def create

    @book = Book.new(book_params)

    if @book.save
      if params[:book][:book_file]
        file = params[:book][:book_file]
        pdf = Magick::Image.read(file.path)
        i = 1
        Dir.mkdir('public/uploads/books/' + @book.id.to_s)
        pdf.each do |pdf_page|
          cover_tmp = Rails.root.join('public/uploads/books/' + @book.id.to_s, i.to_s + ".jpg")
          pdf_page.write cover_tmp
          i += 1
        end
      end
      flash[:success] = "デジタルコンテンツの登録を受け付けました"
      redirect_to root_path
    else
      render :index
    end
  end

  # Index
  def index
    @book_list = Book.all
  end

  # Show
  def show
    @book = Book.find(params[:id])
  end


  private
    # Params
    def book_params
      params.require(:book).permit(:name, :author, :abstract, :required_point)
    end
end