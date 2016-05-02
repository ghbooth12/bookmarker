class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_topic, only: [:edit, :update, :destroy]
  before_action :user_sign_in?, only: [:new, :create]
  before_action :user_authorized?, only: [:edit, :update, :destroy]

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
      flash[:alert] = "Saving topic failed."
      redirect_to topics_path
    end
  end

  def show
    @topic = Topic.find(params[:id])
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
      flash[:alert] = "Updating topic failed."
      redirect_to topics_path
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = "Topic was deleted successfully."
      redirect_to topics_path
    else
      flash[:alert] = "Deleting topic failed."
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

  def user_sign_in?
    unless current_user
      flash[:alert] = "Please sign in to proceed."
      redirect_to new_user_session_path and return
    end
  end

  def user_authorized?
    unless current_user == @topic.user
      flash[:alert] = "Sorry. You are not authorized for this."
      redirect_to topics_path and return
    end
  end
end
