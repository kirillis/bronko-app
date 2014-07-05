class Post < ActiveRecord::Base
  # hooks

  # relations
  belongs_to :sub
  belongs_to :user
  has_many :comments, :order => 'created_at DESC'
  has_one :popmeter, as: :votable

  # validations
  validates :title, presence: true
  validates :text, presence: true
  validates :link, presence: true

  def upvotes
    self.popmeter.upvotes
  end

  def downvotes
    self.popmeter.downvotes
  end

end
