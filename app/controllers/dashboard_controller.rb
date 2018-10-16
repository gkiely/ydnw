class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to google_drive_authorize_path if current_user.google_auth_token.nil?
    @posts = current_user.posts.most_recent_first
  end
end
