#to make git work proerply (password prompt fix)
default_run_options[:pty] = true

#basic stuff
set :application, "litmusk"
set :repository,  "git@github.com:clearassembly/litmusk.git"

set :domain,  "litmusk.clearassembly.com" 
set :user,    "git" 

#Git setup
set :scm, :git
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

set :deploy_to, "/var/www/vhosts/#{domain}" 
set :use_sudo, false 
set :keep_releases, 2 

role :web, "litmusk.clearassembly.com"                          # Your HTTP server, Apache/etc
role :app, "litmusk.clearassembly.com"                          # This may be the same as your `Web` server
role :db,  "litmusk.clearassembly.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end