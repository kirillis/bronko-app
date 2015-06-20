class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.includes(
      { :posts => [:popmeter, :user] },
      { :comments => [:post, :user, :popmeter] },
      :subs => :posts)
    .find(params[:id])
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
        flash[:success] = "Your account has been created."
        redirect_to @user
        return

      else
        flash[:error] = "Error creating account."
        render "new"
        return
      end

    else
      flash[:error] = "Please fill out all the fields."
      render "new"
    end
  end

  def user_posts
    @user = User.includes(posts: [:popmeter, :user]).find(params[:id])
    render 'user_posts'
  end

  def user_subs
    @user = User.includes(subs: :posts).find(params[:id])
    render 'user_subs' 
  end

  def user_comments
    @user = User.includes(comments: [:post, :user, :popmeter]).find(params[:id])
    render 'user_comments'
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end