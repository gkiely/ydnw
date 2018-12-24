class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Updated user!"
      redirect_to user_root_path
    else
      flash[:error] = "An error occurred"
      redirect_to user_root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :username, :bio, :twitter, :instagram, :avatar, :favicon)
  end
end
