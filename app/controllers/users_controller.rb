class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_bookmarks = @user.bookmarks
    @liked_bookmarks = @user.likes.map {|l|
      Bookmark.find_by(id: l.bookmark_id)
    }
  end
end
