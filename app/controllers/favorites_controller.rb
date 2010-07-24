class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @title = 'My Saves'
    @videos = current_user.videos_favorited.active

    render :action => 'videos/list'
  end

  def toggle
    user = User.find current_user.id
    @video = Video.find params[:id]
    if user.has_favorited(@video)
      user.videos.delete(@video)
      @text = 'save'
    else
      user.videos << @video
      @text = 'saved'
    end
    # prepare data to pass to js
    @id = '.video_' + @video.id.to_s
  end

end
