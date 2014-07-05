class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    user = User.find(params[:id])
    if User.find(params[:id]).destroy
      flash[:success] = "User '#{user.username}'' deleted."
    else
      flash[:error] = "Error deleting account."
    end

    redirect_to users_path

  end

  def create
    @user = User.new(user_params)

    if @user.valid?

      if @user.save
        flash[:success] = "Account created."
        redirect_to @user
        return

      else
        flash[:alert] = "Error creating account."
        render "new"
        return
      end

    else
      flash[:alert] = "Form fields missing."
      render "new"
    end

  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end