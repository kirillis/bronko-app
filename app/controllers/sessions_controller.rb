class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by username: params[:session][:username]

    if user && user.authenticate(params[:session][:password])
      flash[:success] = "You are now logged in."
      sign_in(user, params[:remember_me])
      redirect_to root_url
      return
    else
      flash.now[:error] = "Your password or username is not correct, please try again."
    end

    render "new"
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
