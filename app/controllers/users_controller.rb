class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Updated user!"
      redirect_to dashboard_path
    else
      flash[:error] = "An error occurred"
      redirect_to dashboard_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :username, :bio)
  end
end
