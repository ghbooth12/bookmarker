class IncomingController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if user = User.find_by(email: params[:sender])
      topic = Topic.find_or_create_by(title: params[:subject], user_id: user.id)
      url = params["body-plain"]

      topic.bookmarks.find_or_create_by(url: url, user_id: user.id)
      head 200
    else
      head 403
    end
  end
end
