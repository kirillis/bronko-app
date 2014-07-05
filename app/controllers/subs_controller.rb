class SubsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    new_sub = current_user.subs.create(sub_params)
    redirect_to new_sub
  end

  def destroy
    if Sub.find(params[:id]).destroy
      flash[:success] = "Sub deleted."
    else
      flash[:alert] = "Error while deleting sub."
    end

    redirect_to subs_path

  end

  private

  def sub_params
    params.require(:sub).permit(:name, :description)
  end
end