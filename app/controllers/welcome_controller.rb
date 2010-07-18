class WelcomeController < ApplicationController

  def index
    @title = 'Videos'
    @videos = current_admin ? Video.all : Video.active

    render :action => 'videos/list'
  end

end
