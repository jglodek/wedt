require 'bundler/capistrano'

set :application, "wedt"
set :repository,  "git@github.com:jglodek/wedt.git"
set :scm, :git


set :user, 'deploy'
set :password, 'dupa123'

set :branch, "master"

set :deploy_via, :remote_cache
set :deploy_to, "/rails/#{application}"
set :use_sudo, false

ssh_options[:keys] = %w(/home/deploy/.ssh/id_rsa)

default_run_options[:pty] = true #PASSWROD PROMPT

#set :migrate_env, 'production'

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "jglodek-vps"                          # Your HTTP server, Apache/etc
role :app, "jglodek-vps"                          # This may be the same as your `Web` server
role :db, "jglodek-vps", :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


after 'deploy:update_code' do
	 run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
end