module SessionsHelper

  # sign in user by creating new token, 
  # storing token in cookie 
  # and update database with token -> user
  def sign_in(user, remember_me)
    remember_token = User.new_remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
    if remember_me == "1"
      cookies.permanent[:remember_token] = remember_token
    else
      cookies[:remember_token] = remember_token
    end
  end

  # setter method for current_user var
  def current_user=(user)
    @current_user = user
  end

  # getter for current_user, use token in cookie to find user in database
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

end
