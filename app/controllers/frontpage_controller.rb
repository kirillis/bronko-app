class FrontpageController < ApplicationController

  def index

    if(params.has_key?(:t))
      @time_selected = params[:t]
      time_range = get_time_range(@time_selected)

      if params[:t] == 'alltime'
        @all_posts = Post.includes(:comments, :user, :sub, :popmeter)
      else
        @all_posts = Post.includes(:comments, :user, :sub, :popmeter).where(:created_at => time_range)
      end
    else
      @time_selected = 'month'
      @all_posts = Post.includes(:comments, :user, :sub, :popmeter).where(:created_at => (1.month.ago..Time.now))
    end
      
    if(params.has_key?(:m))
      @sort_selected = params[:m]
      @all_posts = sort_objects(@all_posts, params[:m])
    else
      @sort_selected = 'hotness'
      @all_posts = sort_objects(@all_posts)
    end
    render('index')
  end

  def my_index

    if(params.has_key?(:t))
      @time_selected = params[:t]
      time_range = get_time_range(@time_selected)

      if params[:t] == 'alltime'
        @all_posts = Post.includes(:comments, :user, :sub, :popmeter).joins("INNER JOIN subscriptions ON posts.sub_id = subscriptions.sub_id").where('subscriptions.user_id' => current_user.id)
      else
        @all_posts = Post.includes(:comments, :user, :sub, :popmeter).joins("INNER JOIN subscriptions ON posts.sub_id = subscriptions.sub_id").where('subscriptions.user_id' => current_user.id, :created_at => time_range )
      end
    else
      @time_selected = 'month'
      @all_posts = Post.includes(:comments, :user, :sub, :popmeter).joins("INNER JOIN subscriptions ON posts.sub_id = subscriptions.sub_id").where('subscriptions.user_id' => current_user.id, :created_at => (1.month.ago..Time.now) )
    end

    if(params.has_key?(:m))
      @sort_selected = params[:m]
      @all_posts = sort_objects(@all_posts, params[:m])
    else
      @sort_selected = 'hotness'
      @all_posts = sort_objects(@all_posts)
    end

    render('my_index')
  end

  def login
    render('login')
  end

  private

    def get_time_range(param)
      return time_range = case param
        when 'hour' then (1.hour.ago..Time.now)
        when 'today' then (1.day.ago..Time.now)
        when 'week' then (1.week.ago..Time.now)
        when 'month' then (1.month.ago..Time.now)
      end
    end

    def sort_objects(objects, param = nil)
      unless param.nil?
        return objects = case param
          when 'hotness' then objects.order('hotness DESC, votes_diff DESC')
          when 'comments' then objects.order('sub_comments DESC, hotness DESC')
          when 'newest' then objects.order('created_at DESC, hotness DESC')
          when 'votes' then objects.order('votes_diff DESC, hotness DESC')
        end
      end
      return objects.order('hotness DESC, votes_diff DESC')
    end


end
