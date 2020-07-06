class BooksController < ApplicationController
  require 'RMagick'
  require "aws-sdk-s3"

  # form
  def form
    if current_user.has_role? :admin or current_user.has_role? :staff
      @book = Book.new
    else
      flash[:danger] = "アクセス権限がありません"
      redirect_to root_path
    end
  end

  # Create
  def create
    @book = Book.new(book_params)

    if @book.save
      if params[:book][:book_file]
        file = params[:book][:book_file]
        pdf = Magick::Image.read(file.path)
        i = 1
        Dir.mkdir('public/uploads/books/' + @book.public_uid.to_s)
        options = set_options
        s3 = Aws::S3::Resource.new(options)
        bucket = s3.bucket(ENV['S3_BUCKET'])
        pdf.each do |pdf_page|
          cover_tmp = Rails.root.join('public/uploads/books/' + @book.public_uid, format("%04d",i) + ".jpg")
          pdf_page.write cover_tmp
          bucket.object(@book.public_uid + "/" + format("%04d",i) + ".jpg").upload_file(cover_tmp)
          File.delete(cover_tmp)
          i += 1
        end
        Dir.rmdir('public/uploads/books/' + @book.public_uid)
      end
      flash[:success] = "デジタルコンテンツの登録を受け付けました"
      redirect_to root_path
    else
      render :index
    end
  end

  # Index
  def index
    @book_list = Book.all.sort do |a, b| (a.required_point <=> b.required_point).nonzero? || (b.updated_at <=> a.updated_at) end
    options = set_options
    @book_thumbnails = []
    @book_list.each do |each_book|
      bucket = Aws::S3::Resource.new(options).bucket(ENV['S3_BUCKET'])
      if Rails.env == 'development'
        @book_thumbnails.push("http://localhost" + bucket.object(each_book.public_uid + '/0001.jpg').public_url.split("http://host.docker.internal")[1])
      end
    end
  end

  # Show
  def show
    @book = Book.find_by(public_uid: params[:id])
    if current_user.point < @book.required_point and current_user.has_role? :guest
      flash[:danger] = "閲覧に必要なポイントが足りていません"
      redirect_to books_path
    end

    options = set_options
    bucket = Aws::S3::Resource.new(options).bucket(ENV['S3_BUCKET'])
    @book_pages = []
    i = 1
    bucket.objects(prefix: @book.public_uid + "/").sort_by{|obj| obj.key}.each do |object|
      if Rails.env == 'development'
        @book_pages.push("http://localhost" + object.public_url.split("http://host.docker.internal")[1])
      end
      i += 1
    end
  end


  private
    def set_options
      option = {:access_key_id => ENV['S3_ACCESS_KEY'],
       :secret_access_key => ENV['S3_SECRET_KEY'],
       :region => ENV['S3_REGION'],
       :endpoint => ENV['S3_ENDPOINT']}
       if Rails.env == 'development'
        option[:force_path_style ] = true
      end
       option
    end

    # Params
    def book_params
      params.require(:book).permit(:name, :author, :abstract, :required_point)
    end
end