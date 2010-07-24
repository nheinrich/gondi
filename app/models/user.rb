class User < ActiveRecord::Base

  # include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  # setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me

  has_many :favorites, :dependent => :destroy
  has_many :videos_favorited, :through => :favorites, :source => :video

  has_many :views, :dependent => :destroy
  has_many :videos_viewed, :through => :views, :source => :video

  def self.facebook_login(access_token)
    # retrieve user info from currently logged in user

    response_hash = MiniFB.get(access_token, 'me')
    # see if the user has an account
    user = User.find_by_fb_user_id response_hash["id"]
    user = User.find_by_email response_hash["email"] if user.nil? && response_hash["email"]
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

  def track_view(video)
    view = views.find_or_create_by_video_id(video.id)
    view.update_attribute('total', view.total ? view.total += 1 : 1)
  end


end
