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
after "deploy:finalize_update", "deploy:bundle"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
  desc "Create link to database.yml in current"
  task :config do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/"
  end
  
  desc "Execute bundle install"
  task :bundle do
    run "cd #{release_path}; #{sudo} bundle install"
  end
end