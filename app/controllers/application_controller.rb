class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_filter :check_for_fb_user_id


  def check_for_fb_user_id
    @current_user ||= User.find session[:fb_user_id] if session[:fb_user_id]
  end

end
