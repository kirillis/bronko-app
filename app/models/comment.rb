class Comment < ActiveRecord::Base
  # relations
  belongs_to :post
  belongs_to :user
  has_one :popmeter, as: :votable

  # add ancestry
  has_ancestry

  # validations
  validates :text, presence: true
  
  def upvotes
    self.popmeter.upvotes
  end

  def downvotes
    self.popmeter.downvotes
  end
end
