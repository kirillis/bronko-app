module FormatHelper

  def formatted_created_at(object)
    object.created_at.strftime("%d. %b %Y")
  end  
end