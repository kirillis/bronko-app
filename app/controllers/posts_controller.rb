class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @sub = Sub.find(params['sub_id'])
    @post = @sub.posts.new
  end

  def edit
  end

  def create
    sub = Sub.find(params['sub_id'])
    post = sub.posts.build(post_params)
    post.user = current_user
    post.popmeter = Popmeter.create

    if post.valid?

      if post.save
        flash[:success] = 'Post was successfully created.'
        redirect_to post
      else
        flash[:alert] = 'Error, post not created.'
        render action: 'new'
      end

    else
      flash[:alert] = "Form fields missing."
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
