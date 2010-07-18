class VideosController < ApplicationController
  before_filter :authenticate_user!, :only => [:save, :saves]
  respond_to :html, :js

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find params[:id]
    respond_to do |format|
      format.html {
        @title = 'Watch'
        @videos = current_admin ? Video.all : Video.active }
      format.js
    end
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find params[:id]
  end

  def create
    if @video = Video.create(params[:video])
      @selector = '#video_'+@video.id.to_s
      respond_with(@video, :location => root_url, :notice => 'Video successfully created')
    else
      respond_with(@video, :location => root_url)
    end
  end

  def update
    @video = Video.find params[:id]
    if @video.update_attributes(params[:video])
      @selector = '#video_'+@video.id.to_s
      respond_with(@video, :location => root_url, :notice => 'Video successfully updated')
    else
      respond_with(@video, :location => root_url)
    end
  end

  def destroy
    @video = Video.find params[:id]
    @video_id = '#video_'+ @video.id.to_s
    @video.destroy
  end

  def save
    user = User.find current_user.id
    @video = Video.find params[:id]
    if user.has_saved(@video)
      user.videos.delete(@video)
      @text = 'save'
    else
      user.videos << @video
      @text = 'saved'
    end
    # prepare data to pass to js
    @id = '#video_' + @video.id.to_s
  end

  def saves
    @title = 'My Saves'
    @videos = current_user.videos
    render :action => 'list'
  end

  def add_athlete
    unless @athlete = Athlete.find_by_name(params[:athlete])
      @athlete = Athlete.new(:name => params[:athlete])
    end
  end

end
