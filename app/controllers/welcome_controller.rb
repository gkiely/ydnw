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
    @users_added = User.where.not(google_auth_token: nil).group("date_trunc('month', created_at) ").count.sort {|a,b| a[0] <=> b[0]}
    @days = @users_added.map { |user| user[0].strftime("%B %Y") }
    @values = @users_added.map { |user| user[1] }

    @posts_added = Post.group("date_trunc('month', created_at) ").count.sort {|a,b| a[0] <=> b[0]}
    @posts_days = @posts_added.map { |post| post[0].strftime("%B %Y") }
    @posts_values = @posts_added.map { |post| post[1] }

    @published_posts_added = Post.where(is_published: true).group("date_trunc('month', created_at) ").count.sort {|a,b| a[0] <=> b[0]}
    @published_posts_days = @published_posts_added.map { |post| post[0].strftime("%B %Y") }
    @published_posts_values = @published_posts_added.map { |post| post[1] }
  end
end
