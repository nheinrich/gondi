if RAILS_ENV == "production"
  Paperclip.options[:command_path] = "/usr/local/bin"
end