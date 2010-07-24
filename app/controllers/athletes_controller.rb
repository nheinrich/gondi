class AthletesController < ApplicationController

  def index
    if params[:q]
      @athletes = Athlete.all(:conditions=>["name like ?", params[:q] + '%'])
    else
      @athletes = Athlete.all
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @athlete = Athlete.find params[:id]
    @title = @athlete.name.titleize
    @videos = current_admin ? @athlete.videos.all : @athlete.videos.active
    render :action => 'videos/list'
  end


end
