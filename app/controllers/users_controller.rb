class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @liked_bookmarks = @user.likes.map(&:bookmark)
  end
end
