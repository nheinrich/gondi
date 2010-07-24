# based off of devise controller, modified to accept facebook

class FacebookController < ApplicationController

  def sign_in
    access_token_hash = MiniFB.oauth_access_token(FB_APP_ID, FB_HOST + 'facebook/sign_in', FB_SECRET, params[:code])
    access_token = access_token_hash["access_token"]
    unless access_token.empty?
      user = User.facebook_login(access_token)
      # this seems nasty, need to look into ways of forcing current_user
      session[:fb_user_id] = user.fb_user_id
    else
      flash[:error] = "We were not able to log you in, please try again."
    end

    redirect_to '/'
  end

  def sign_out
    session[:fb_user_id] = nil
    redirect_to destroy_user_session_url
  end

end
