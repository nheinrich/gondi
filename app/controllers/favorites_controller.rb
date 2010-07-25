class FavoritesController < ApplicationController

  def index
    @title = 'My Saves'
    @videos = current_user.videos_favorited.active

    render :template => 'videos/list'
  end

  def toggle
    if user_signed_in?
      user = User.find current_user.id
      @video = Video.find params[:id]
      if user.has_favorited(@video)
        user.videos_favorited.delete(@video)
        @text = 'save'
      else
        user.videos_favorited << @video
        @text = 'saved'
      end
      # prepare data to pass to js
      @selector = '.video_' + @video.id.to_s
    else
      redirect_to new_user_session_url
    end
  end

end
