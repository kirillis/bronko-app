module CommentsHelper

  def nested_comments(comments)    
    comments.map do |comment, sub_comments|
      render(comment) + content_tag(:div, nested_comments(sub_comments), :class => 'comment__comments-wrapper')
    end.join.html_safe

  end
end