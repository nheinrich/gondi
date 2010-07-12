class WelcomeController < ApplicationController

  def index
    @title = 'Videos'
    @videos = Video.active
  end

end
