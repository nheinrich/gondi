class User < ActiveRecord::Base

  # include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me

  has_many :favorites
  has_many :videos, :through => :favorites

  def self.facebook_login(access_token)
    # retrieve user info from currently logged in user

    response_hash = MiniFB.get(access_token, 'me')
    # see if the user has an account
    user = User.find_by_fb_user_id response_hash["id"]
    user = User.find_by_email response_hash["email"] if user.nil?
    user = User.new if user.nil?

    # update stats
    user.email = response_hash["email"] unless response_hash["email"].blank?
    user.fb_access_token = access_token
    user.fb_user_id = response_hash["id"] unless response_hash["id"].blank?
    user.save!
    user
  end

  def has_favorited(video)
    favorites.map(&:video_id).include? video.id
  end

end
