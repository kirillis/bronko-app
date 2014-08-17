class Sub < ActiveRecord::Base

  # relations
  has_many :posts, :order => 'created_at DESC'
  has_many :subscriptions
  has_many :users, through: :subscriptions
  belongs_to :user

  # scopes
  scope :visible, -> { where(:visible => true) }
  scope :invisible, -> { where(:visible => false) }

  # validations
  validates :name, presence: true

  def self.search(name)
    where('name LIKE ?', '%'+name+'%')
  end
end
