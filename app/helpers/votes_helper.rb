module VotesHelper
  
  def render_votes(votable_obj)
    render partial: "layouts/voter", locals: {obj: votable_obj}
  end  
end