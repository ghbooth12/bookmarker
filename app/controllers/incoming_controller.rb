class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user  = User.find_or_create_by(username: params[:sender])
    topic = Topic.find_or_create_by(title: params[:subject])
    url   = params["body-plain"]

    topic.bookmarks.create(url: url, user_id: user.id)
    head 200
  end
end
