class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    file = GoogleDrive.new(current_user).create_file!

    current_user.posts.create(
      title: "My new post.",
      google_doc: file.id,
      published: Date.today,
      is_published: true
    )

    redirect_to user_root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to edit_post_path(@post.id)
    else
      flash[:error] = "something went wrong"
      redirect_to edit_post_path(@post.id)
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy!
      flash[:success] = "Post updated!"
      redirect_to user_root_path
    else
      flash[:error] = "something went wrong"
      redirect_to user_root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :published, :is_published)
  end
end
