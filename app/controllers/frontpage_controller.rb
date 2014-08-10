class FrontpageController < ApplicationController

  def index
    @time_array = [['Last hour', 'hour'], ['Today', 'today'], ['Week', 'week'], ['Month', 'month'], ['Alltime', 'alltime']]
    @sort_options_array = [['Hotness', 'hotness'], ['Comments', 'comments'], ['Votes', 'votes'], ['Newest', 'newest']]

    if(params.has_key?(:t))
      @time_selected = params[:t]
      time_range = case params[:t]
        when 'hour' then (1.hour.ago..Time.now)
        when 'today' then (1.day.ago..Time.now)
        when 'week' then (1.week.ago..Time.now)
        when 'month' then (1.month.ago..Time.now)
      end

      if params[:t] == 'alltime'
        @all_posts = Post.all
      else
        @all_posts = Post.where(:created_at => time_range)
      end
    else
      @time_selected = 'today'
      @all_posts = Post.where(:created_at => (1.day.ago..Time.now))
    end

      
    if(params.has_key?(:m))
      @sort_selected = params[:m]
      @all_posts = case params[:m]
        when 'hotness' then @all_posts.order('hotness DESC, votes_diff DESC')
        when 'comments' then @all_posts.order('sub_comments DESC, hotness DESC')
        when 'newest' then @all_posts.order('created_at DESC, hotness DESC')
        when 'votes' then @all_posts.order('votes_diff DESC, hotness DESC')
      end

    else
      @sort_selected = 'hotness'
      @all_posts = @all_posts.order('hotness DESC, votes_diff DESC')
    end
    render('index')
  end

  def login
    render('login')
  end
end
