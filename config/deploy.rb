set :application, "vimpusher"
set :repository,  "git@github.com:banyan/Vimpusher.git"

set :scm, :git
set :port, 10022

role :resque_worker, "vimpusher.resque-worker.mi.nu"

default_run_options[:pty] = true
set :use_sudo, true

set :workers, { "crawler_queue" => 4 }

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
