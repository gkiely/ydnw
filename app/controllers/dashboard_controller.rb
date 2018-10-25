class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    return redirect_to google_drive_authorize_path if current_user.google_auth_token.nil?
    return redirect_to "/#{current_user.username}"
  end
end
