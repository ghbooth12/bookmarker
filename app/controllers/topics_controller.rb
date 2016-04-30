class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new

    respond_to do |format|
      format.js { render 'topics/new.js.erb' }
    end
  end

  def create
    @topic = current_user.topics.build(topic_params)

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "Saving topic failed."
      redirect_to topics_path
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.js { render 'topics/edit.js.erb' }
    end
  end

  def update
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "Updating topic failed."
      redirect_to topics_path
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = "Topic was deleted successfully."
      redirect_to topics_path
    else
      flash.now[:alert] = "Deleting topic failed."
      redirect_to topics_path
    end
  end

  private

  def set_topic
    @topic = current_user.topics.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
