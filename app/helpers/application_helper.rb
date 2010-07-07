module ApplicationHelper

  def facebook_auth_path
    MiniFB.oauth_url(FB_APP_ID, HOST + 'facebook/sign_in') # gets all permissions
  end



end
