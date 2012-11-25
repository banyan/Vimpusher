set :application, "vimpusher"
set :repository,  "git@github.com:banyan/Vimpusher.git"

set :scm, :git
set :port, 10022

role :resque_worker, "vimpusher.resque-worker.mi.nu"

default_run_options[:pty] = true
set :use_sudo, true

set :workers, { "crawler_queue" => 4 }

namespace :deploy do
  task :set_symbolic_link, :roles => :resque_worker do
    sudo "ln -s /etc/vimpusher/config/database.yml #{release_path}/config/database.yml"
    sudo "ln -s /etc/vimpusher/config/oauth.yml #{release_path}/config/oauth.yml"
    sudo "ln -s /etc/vimpusher/config/redis.yml #{release_path}/config/redis.yml"
    sudo "ln -s /etc/vimpusher/config/initializers/resque_auth.rb #{release_path}/config/initializers/resque_auth.rb"
  end
end
before 'deploy:create_symlink', 'deploy:set_symbolic_link'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
