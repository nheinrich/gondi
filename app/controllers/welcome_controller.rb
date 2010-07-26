class WelcomeController < ApplicationController

  def index
    @title = 'Videos'
    @videos = current_admin ? Video.all : Video.active

    render :template => 'videos/list'
  end

  def info

  end

end
