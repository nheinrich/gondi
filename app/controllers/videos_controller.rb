class VideosController < ApplicationController

  respond_to :html, :js

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find params[:id]
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

  def add_athlete
    unless @athlete = Athlete.find_by_name(params[:athlete])
      @athlete = Athlete.new(:name => params[:athlete])
    end
  end

end
