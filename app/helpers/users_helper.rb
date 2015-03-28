module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user if email available
  def gravatar_for(user)
    if user.email?
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
      image_tag(gravatar_url, alt: user.username, class: "userDetails-avatarImage")
    else
      image_tag("http://placehold.it/150x150", alt: "avatar image missing", class: "userDetails-avatarImage")
    end
  end

end