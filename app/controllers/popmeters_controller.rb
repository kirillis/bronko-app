class PopmetersController < ApplicationController

  def update

    popmeter = Popmeter.find(params['id'])

    # create/update user vote
    # if already voted, change old vote
    v = popmeter.votes.find_by(user_id: current_user.id)

    if v.nil?

      # create new vote
      popmeter.votes.create(user_id: current_user.id, is_upvote: params['is_upvote'])
      
      # add new vote to popmeter votes
      if params['is_upvote'] == "true"
        popmeter.upvotes += 1
      else
        popmeter.downvotes += 1
      end

    else

      # if vote by user for popmeter already exists, change to value to opposite
      if v.is_upvote
        popmeter.upvotes -= 1
        popmeter.downvotes += 1
      else
        popmeter.upvotes += 1
        popmeter.downvotes -= 1
      end

      # update old vote
      v.update_attributes(user_id: current_user.id, is_upvote: params['is_upvote'])
      
    end

    respond_to do |format|
      if popmeter.save
        format.html { redirect_to popmeter.votable }
        format.js   {}
        format.json { render json: popmeter, status: :created, location: popmeter.votable }
      else
        format.html { redirect_to root }
        format.js   {}
        format.json { render json: popmeter.errors, status: :error }
      end
    end
  end

  def destroy
    popmeter = Popmeter.find(params['id'])
    v = Vote.find_by(user_id: current_user.id, popmeter_id: popmeter.id)

    # delete old vote form upvotes/downvotes total
    if v.is_upvote
      popmeter.upvotes -= 1
    else
      popmeter.downvotes -= 1
    end

    popmeter.save

    # delete vote
    v.destroy

    redirect_to popmeter.votable 
  end
end