class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:edit, :update, :destroy]

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new

    respond_to do |format|
      format.js { render 'bookmarks/new.js.erb' }
    end
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully."
      redirect_to topic_path(@topic)
    else
      flash[:alert] = "Saving bookmark failed."
      redirect_to topic_path(@topic)
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'bookmarks/edit.js.erb' }
    end
  end

  def update
    authorize @bookmark
    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark was updated successfully."
      redirect_to topic_path(@topic)
    else
      flash[:alert] = "Updating bookmark failed."
      redirect_to topic_path(@topic)
    end
  end

  def destroy
    authorize @bookmark
    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted successfully."
      redirect_to topic_path(@topic)
    else
      flash[:alert] = "Deleting bookmark failed."
      redirect_to topic_path(@topic)
    end
  end

  private

  def set_bookmark
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
