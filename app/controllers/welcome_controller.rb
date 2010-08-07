class WelcomeController < ApplicationController

  def index
    @title = 'gondi.tv'
    @videos = Video.active.paginate(:page => params[:page], :per_page => 15)
    render :template => 'videos/list'
  end

  def info

  end

end
