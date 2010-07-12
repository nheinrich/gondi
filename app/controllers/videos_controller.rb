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
    @video = Video.new params[:video]
    respond_to do |format|
      if @video.save
        format.html { redirect_to(@video, :notice => 'Video successfully created') }
        format.js
      else
        format.html { render :action => 'new' }
        format.js
      end
    end
  end

  def update
    @video = Video.find params[:id]
    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to(@video, :notice => 'Video successfully updated') }
        format.js
      else
        format.html { render :action => 'edit' }
        format.js
      end
    end
  end

  def destroy
    @video = Video.find params[:id]
  end

  def add_athlete
    unless @athlete = Athlete.find_by_name(params[:athlete])
      @athlete = Athlete.new(:name => params[:athlete])
    end
  end

end
