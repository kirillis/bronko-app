class FrontpageController < ApplicationController
  def index
    @post = Post.all
    @post.sort_by {|post| post.hotness}
    render('index')
  end

  def login
    render('login')
  end
end
