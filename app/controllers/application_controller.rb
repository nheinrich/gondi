class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_filter :check_for_facebook_user

  def check_for_facebook_user
    @current_user ||= User.find_by_fb_user_id session[:fb_user_id] if session[:fb_user_id]
  end

end
