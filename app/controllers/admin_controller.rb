class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @title = "Admin"
    @videos = Video.all.paginate(:page => params[:page], :per_page => 25)
    render :template => 'videos/list'
  end

end
