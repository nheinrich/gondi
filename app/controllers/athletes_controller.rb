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


end
