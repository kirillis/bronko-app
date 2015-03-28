class SubsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def show
    @sort_options_array = [['Hotness', 'hotness'], ['Comments', 'comments'], ['Votes', 'votes'], ['Newest', 'newest']]

    @sub = Sub.find(params[:id])

    if(params.has_key?(:m))
      @sort_selected = params[:m]
      @all_posts = case params[:m]
        when 'hotness' then @sub.posts.order('hotness DESC, votes_diff DESC')
        when 'comments' then @sub.posts.order('sub_comments DESC, hotness DESC')
        when 'newest' then @sub.posts.order('created_at DESC, hotness DESC')
        when 'votes' then @sub.posts.order('votes_diff DESC, hotness DESC')
      end

    else
      # debugger
      @sort_selected = 'hotness'
      @all_posts = @sub.posts.includes(:comments, :user, :popmeter).order('hotness DESC')
    end

    if(params.has_key?(:t))
      @time_selected = params[:t]
      time_range = case params[:t]
        when 'hour' then (1.hour.ago..Time.now)
        when 'today' then (1.day.ago..Time.now)
        when 'week' then (1.week.ago..Time.now)
        when 'month' then (1.month.ago..Time.now)
      end

      if params[:t] != 'alltime'
        @all_posts = @all_posts.where(:created_at => time_range)
      end
    else
      @time_selected = 'alltime'
    end
    render('show')
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