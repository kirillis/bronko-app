module ApplicationHelper

  def render_post_teaser(post)
    render partial: "layouts/post_teaser", locals: {post: post}
  end

  def render_votes(votable_obj)
    render partial: "layouts/voter", locals: {obj: votable_obj}
  end

  def is_user_subscribed?(sub)
    sub.users.where(:id => current_user.id).any?
  end


  def recalculate_hotness
    popmeterAll = Popmeter.where(votable_type: "Post")

    popmeterAll.each do |popmeter|
      p = popmeter.votable_type
      p.hotness = recalculate_hotness

      if(p.save)
        puts "Calculating hotness for post #{post.id}: #{post.hotness}"
      else
        puts "Error saving post with id: #{post.id}"
      end

    end

    puts "All finished!"
  end
end
