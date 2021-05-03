class UsersController < ApplicationController
  before_action :baria_user, only: [:edit, :destroy, :update]

  def show
    @book_new = Book.new
    @user = User.find(params[:id])
    @books = @user.books.all
  end

  def index
    @book_new = Book.new
    @user = User.find(current_user.id)
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render ("/users/edit")
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def baria_user
    unless User.find(params[:id]).id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
