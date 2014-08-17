class SessionsController < ApplicationController

  def new
  end

  def create
    logger.debug "New post: #{params}"
    user = User.find_by username: params[:session][:username]

    if user && user.authenticate(params[:session][:password])
      flash[:success] = "correct"
      sign_in(user, params[:remember_me])
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
