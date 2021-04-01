class BooksController < ApplicationController
  before_action :baria_user, only: [:edit, :destroy, :update]
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @book_new = @book
      @user = User.find(current_user.id)
      render("/books/index")
    end
  end

  def index
    @books = Book.all
    @book_new = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else 
      render ("/books/edit")
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    flash[:notice] = "Book was successfully destroyed."
    book.destroy
    redirect_to("/books")
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def baria_user
    unless Book.find(params[:id]).user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
