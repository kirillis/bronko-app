class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by username: params[:session][:username]

    if user && user.authenticate(params[:session][:password])
      flash[:success] = "correct"
      sign_in user
      redirect_to root_url
      return
    else
      flash.now[:error] = "so wrong"
    end

    render "new"
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
