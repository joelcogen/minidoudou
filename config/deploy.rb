require 'capistrano_colors'
require "whenever/capistrano"

default_run_options[:pty] = true
set :repository, "git@github.com:joelcogen/minidoudou.git"
set :scm, "git"
set :user, "joel"
set :ssh_options, {:forward_agent => true}
set :use_sudo, false
set :application, "minidoudou"
set :deploy_to, "/home/joel/joelcogen.com/minidoudou.cap"
set :rails_env, "production"

role :web, "joelcogen.com"
role :app, "joelcogen.com"
role :db,  "joelcogen.com", :primary => true

after "deploy:finalize_update", "deploy:config"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
  task :config do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/"
  end
end