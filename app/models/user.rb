class User < ActiveRecord::Base

  attr_accessible :email, :password, :remember_me

  devise :database_authenticatable, :facebook_open_graph_authenticatable,
    :registerable, :recoverable, :rememberable, :trackable

  has_many :favorites, :dependent => :destroy
  has_many :videos_favorited, :through => :favorites, :source => :video

  has_many :views, :dependent => :destroy
  has_many :videos_viewed, :through => :views, :source => :video

  # before_create_by_facebook :extract_user_data_from_facebook_session

  def has_favorited(video)
    favorites.map(&:video_id).include? video.id
  end

  def track_view(video)
    view = views.find_or_create_by_video_id(video.id)
    view.update_attribute('total', view.total ? view.total += 1 : 1)
  end

  # not currently in use, included for example purposes
  def extract_user_data_from_facebook_session
    user = facebook_session.graph.get_object(:me)
  end
end
