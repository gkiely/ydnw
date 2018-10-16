class I::PostsController < ApplicationController
  def index
    @user = User.find_by(username: params[:username])
    return redirect_to root_path unless @user

    @posts = @user.posts.most_recent_first
  end

  def show
    @user = User.find_by(username: params[:username])
    return redirect_to root_path unless @user

    @post = @user.posts.find(params[:post_id])
    html = GoogleDrive.new(@user).get_html(@post)
    @parsed = Nokogiri::HTML::DocumentFragment.parse(html).to_html
    @text_of_post = Nokogiri::HTML(@parsed).text
  end
end
