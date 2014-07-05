class User < ActiveRecord::Base
  # hooks
  before_save { email = self.email.downcase }

  # relations
  has_many :posts, :order => 'created_at DESC'
  has_many :subs, :order => 'created_at DESC'
  has_many :comments, :order => 'created_at DESC'
  has_many :votes

  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email,  uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  # hash password
  has_secure_password

  def voted_for(votable_obj, user)
    Vote.find_by(popmeter_id: votable_obj.popmeter.id, user_id: user.id)
  end

  # create new token for the cookie
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # create secured token for the database
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    # create and set secured token on self
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
