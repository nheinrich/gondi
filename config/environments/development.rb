Gondi::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Facebook
end


FB_API_KEY = '009777b3f6638ad9375435752839d943'
FB_SECRET = 'd1403d03e5163bd731e3e23a90bb9c77'
FB_APP_ID = '136218683069813'
FB_HOST = 'http://g.tv:3000/'