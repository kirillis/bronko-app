class SubscriptionsController < ApplicationController

  def new
    @sub = Sub.find(params['sub_id'])
    @sub.subscribers << current_user
    redirect_to @sub
  end

  def destroy
    @sub = Sub.find(params['id'])
    subscription = Subscription.find_by(:sub_id => @sub.id, :user_id => current_user.id)
    if subscription
      subscription.delete
    end
    redirect_to @sub
  end
end