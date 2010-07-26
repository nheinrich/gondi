class WelcomeController < ApplicationController

  def index
    @title = 'gondi.tv'
    @videos = current_admin ? Video.all : Video.active

    render :template => 'videos/list'
  end

  def info

  end

end
