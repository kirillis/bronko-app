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

  def my_posts
    if signed_in?
      @user = User.includes(posts: [:popmeter, :user]).find(current_user.id)
      render 'my_posts'
    else
      flash[:error] = "You need to be logged in to view this page."
      redirect_to root_path
    end      
  end

  def my_subs
    if signed_in?
      @user = User.includes(subs: :posts).find(current_user.id)
      render 'my_subs'
    else
      flash[:error] = "You need to be logged in to view this page."
      redirect_to root_path
    end      
  end

  def my_comments
    if signed_in?
      @user = User.includes(comments: [:post, :user, :popmeter]).find(current_user.id)
      render 'my_comments'
    else
      flash[:error] = "You need to be logged in to view this page."
      redirect_to root_path
    end      
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end