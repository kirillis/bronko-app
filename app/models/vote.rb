class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :popmeter

  def self.build_for_popmeter(popmeter, current_user)

    # if already voted, change old vote
    vote = Vote.find_by(popmeter_id: popmeter.id, user_id: current_user.id)

    if vote.nil?
      create(votable_id: votable_obj.id, votable_type: votable_obj.class.to_s, is_upvote: is_upvote)
    else
      vote.update(is_upvote: is_upvote)
    end

  end
end