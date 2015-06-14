class Post < ActiveRecord::Base
  # hooks

  # relations
  belongs_to :sub
  belongs_to :user
  has_many :comments
  has_one :popmeter, as: :votable

  # validations
  validates :title, presence: true, length: { maximum: 130 }
  validates :link, presence: true
  validates :text, length: { maximum: 1200 }

  self.per_page = 30

  def total
    self.popmeter.total
  end

  def upvotes
    self.popmeter.upvotes
  end

  def downvotes
    self.popmeter.downvotes
  end

end
