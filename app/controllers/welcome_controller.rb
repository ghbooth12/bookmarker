class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @test_user = User.find_by(email: "test@test.io")
    @topic = Topic.first
  end

  def auto_sign
    tester = User.find_by(email: "test@test.io")
    sign_in(tester)
    flash[:notice] = "You are signed in as test user."
    redirect_to root_path
  end
end
