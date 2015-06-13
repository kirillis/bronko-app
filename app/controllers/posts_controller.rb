class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @time_array = [['Last hour', 'hour'], ['Today', 'today'], ['Week', 'week'], ['Month', 'month'], ['Alltime', 'alltime']]
    @sort_options_array = [['Score', 'score'], ['Comments', 'comments'], ['Votes', 'votes'], ['Newest', 'newest']]


    if(params.has_key?(:sortRange))
      @time_selected = params[:sortRange]
      time_range = case params[:sortRange]
        when 'hour' then (1.hour.ago..Time.now)
        when 'today' then (1.day.ago..Time.now)
        when 'week' then (1.week.ago..Time.now)
        when 'month' then (1.month.ago..Time.now)
      end

      if params[:sortRange] == 'alltime'
        all_comments = @post.comments
      else
        all_comments = @post.comments.where(:created_at => time_range)
      end
    else
      @time_selected = 'alltime'
      all_comments = @post.comments
    end

      
    if(params.has_key?(:sortBy))
      @sort_selected = params[:sortBy]
      @comments = case params[:sortBy]
        when 'score' then all_comments.arrange(:order => 'score DESC, votes_diff DESC')
        when 'comments' then all_comments.arrange(:order => 'sub_comments DESC, score DESC')
        when 'newest' then all_comments.arrange(:order => 'created_at DESC, score DESC')
        when 'votes' then all_comments.arrange(:order => 'votes_diff DESC, score DESC')
      end

    else
      @sort_selected = 'score'
      @comments = all_comments.arrange(:order => 'score DESC, votes_diff DESC')
    end
  end

  def new
    @sub = Sub.find(params['sub_id'])
    @post = @sub.posts.new
  end

  def edit
  end

  def create
    @sub = Sub.find(params['sub_id'])
    @post = @sub.posts.build(post_params)
    @post.user = current_user
    @post.popmeter = Popmeter.create

    if @post.valid?

      if @post.save
        flash[:success] = 'Post was successfully created.'
        redirect_to @post
      else
        flash[:alert] = 'Error, post not created.'
        render action: 'new'
      end

    else
      flash[:alert] = "Something went wrong."
      render "new"
    end
  end

  def update

    if post.update(post_params)
      redirect_to post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    post.destroy
    redirect_to posts_url
  end

  private

    def post_params
      params.require(:post).permit(:link, :title, :text)
    end
end
