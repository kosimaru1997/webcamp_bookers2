class BookCommentsController < ApplicationController
  before_action :baria_user, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    @book = Book.find(params[:book_id])
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
    # redirect_to book_path(book)
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    @book = Book.find(params[:book_id])
    @book_comments = @book.book_comments
  end

  private

   def book_comment_params
     params.require(:book_comment).permit(:comment)
   end

  def baria_user
    unless BookComment.find_by(id: params[:id], book_id: params[:book_id]).user == current_user
      redirect_to books_path
    end
  end
end
