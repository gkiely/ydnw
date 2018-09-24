class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    pathy = current_user.email.include?("google.com") ? google_drive_authorize_path : waitlist_path
    redirect_to pathy if current_user.google_auth_token.nil?
    @posts = current_user.posts
  end
end
