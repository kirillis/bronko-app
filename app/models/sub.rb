class Sub < ActiveRecord::Base

  # relations
  has_many :posts
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, :source => :user
  belongs_to :user

  # scopes
  scope :visible, -> { where(:visible => true) }
  scope :invisible, -> { where(:visible => false) }
  scope :posts_created_after, ->(time) { self.posts.where("created_at > ?", time) }

  # validations
  validates :name, presence: true

  def self.search(name)
    where('name LIKE ?', '%'+name+'%')
  end
end
