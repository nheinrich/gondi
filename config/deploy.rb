#############################################################
#	Application
#############################################################
require 'capistrano/ext/multistage'
set :stages, %w(staging production)
set :default_stage, "staging"
set :application, "gondi"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

#############################################################
#	Servers
#############################################################

set :user, 'deploy'
set :use_sudo, false
set :gateway, 'gate.pixels-and-bits.com'
role :web, 'web.pixels-and-bits.com'
role :app, 'app1.pixels-and-bits.com'
role :db, 'app1.pixels-and-bits.com', :primary => true

#############################################################
#	Git
#############################################################

set :scm, :git
# set (:branch) { stage }
set :scm_user, 'deploy'
set :repository, "git@github.com:nheinrich/#{application}.git"
set (:deploy_to) { "/var/webapps/#{application}/website/#{stage}" }
set :deploy_via, :remote_cache
set :scm_verbose, true

#############################################################
#	recipes
#############################################################

namespace :deploy do
  desc "Check the path that Capistrano uses"
  task :check_path, :roles => :db do
    run "echo $PATH"
  end

  desc "This to do once we get the code up"
  task :after_update_code, :roles => :app, :except => { :no_release => true } do
    run "cp #{shared_path}/database.yml #{release_path}/config/"
    run "sudo -i cd #{release_path} && bundle install"
    run "cd #{release_path} && RAILS_ENV=#{stage} ./script/rails runner Sass::Plugin.update_stylesheets"
    run "cd #{release_path} && RAILS_ENV=#{stage} rake db:migrate"
    # update_crontab
  end

  #########################################################
  # Uncomment the following to symlink an uploads directory.
  # Just change the paths to whatever you need.
  #########################################################

  # desc "Symlink the upload directories"
  # task :before_symlink do
  #   run "mkdir -p #{shared_path}/system_images/images"
  #   run "ln -s #{shared_path}/system_images/images #{release_path}/public/system/images"
  # end

  # whenever / crontab udpate
  # desc "Update the crontab file"
  # task :update_crontab, :roles => :db do
  #   run <<-EOC
  #     cd #{release_path} &&
  #     RAILS_ENV=#{stage} whenever --set environment=#{stage} --update-crontab #{application}
  #   EOC
  # end

  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :db do
  desc 'Dumps the production database to db/production_data.sql on the remote server'
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do
    run "cd #{deploy_to}/#{current_dir} && " +
      "rake RAILS_ENV=#{rails_env} db:database_dump --trace"
  end

  desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
  task :remote_db_download, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/production_data.sql", "db/production_data.sql")
      end
    end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/production_data.sql"
      end
    end
  end

  desc 'Dumps, downloads and then cleans up the production data dump'
  task :remote_db_runner do
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end
end