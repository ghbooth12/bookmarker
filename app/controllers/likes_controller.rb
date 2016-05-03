class LikesController < ApplicationController
  def index
    @like = current_user.likes
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.new(bookmark_id: @bookmark.id)
    authorize @like

    if @like.save
      @msg = "Liked!"
    else
      @msg = "Fail to like."
    end

    respond_to do |format|
      format.js { render 'likes/create.js.erb' }
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @like = current_user.likes.find(params[:id])
    authorize @like

    if @like.destroy
      @msg = "Unliked!"
    else
      @msg = "File to unlike"
    end

    respond_to do |format|
      format.js { render 'likes/destroy.js.erb' }
    end
  end
end
