# Load the rails application
require File.expand_path('../application', __FILE__)

# facebook info
config = YAML::load(File.open(File.expand_path("config/facebook.yml")))

FB_API_KEY = config['fb_api_key']
FB_SECRET = config['fb_secret']
FB_APP_ID = config['fb_app_id']
HOST = config['host']

# Initialize the rails application
Gondi::Application.initialize!