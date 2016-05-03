class IncomingController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if user = User.find_by(email: params[:sender])
      url = params["body-plain"]
      if topic = Topic.find_by(title: params[:subject])
        topic.bookmarks.find_or_create_by(url: url, user_id: user.id)
      else
        topic = Topic.create(title: params[:subject], user_id: user.id)
        topic.bookmarks.create(url: url, user_id: user.id)
      end
      head 200
    else
      render(json: "Unregistered Email")
      head 200
    end
  end
end
