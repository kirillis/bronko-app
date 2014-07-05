class FrontpageController < ApplicationController
  def index
    @subs = Sub.all
    render('index')
  end

  def login
    render('login')
  end
end
