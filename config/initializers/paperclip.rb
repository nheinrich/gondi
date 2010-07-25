if RAILS_ENV == "development"
  Paperclip.options[:command_path] = "/opt/local/bin"
end
if RAILS_ENV == "production"
  Paperclip.options[:command_path] = "/usr/local/bin"
end