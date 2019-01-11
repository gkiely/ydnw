class WelcomeController < ApplicationController
  def index
    # logger.debug "-----------------"
    # logger.debug "-----------------"
    # logger.debug "-----------------"
    # logger.debug "-----------------"
    # logger.debug request.host
    # logger.debug "-----------------"
    # logger.debug "-----------------"
    # logger.debug "-----------------"
    # logger.debug "-----------------"
  end

  def open
    @users_added = User.group("date_trunc('day', created_at) ").count.sort {|a,b| a[0] <=> b[0]}
    @days = @users_added.map { |user| user[0].strftime("%d %B %Y") }
    @values = @users_added.map { |user| user[1] }

    @authed_users_added = User.where.not(google_auth_token: nil).group("date_trunc('day', created_at) ").count.sort {|a,b| a[0] <=> b[0]}
    # @days = @users_added.map { |user| user[0].strftime("%d %B %Y") }
    @authed_values = @authed_users_added.map { |user| user[1] }
  end
end
