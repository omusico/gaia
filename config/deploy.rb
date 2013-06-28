require 'capistrano/ext/multistage'
require 'bundler/capistrano'

# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

begin
  require 'capistrano_colors'
rescue LoadError
  puts "`gem install capistrano_colors` to get output more userfriendly."
end


set :application, "gaia"
set :repository,  "git@github.com:marsz/gaia.git"

set :scm, :git

set :stages,        %w(production)
set :default_stage, "production"

set :rvm_type, :system
set :scm_verbose, true
set :use_sudo, false

require "rvm/capistrano"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => [:app] do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  task :symlink_shared, :roles => [:app] do
    config_files = [:database, :setting]
    symlink_hash = {}
    config_files.each do |fname|
      symlink_hash["#{shared_path}/config/#{fname}.yml"] = "#{release_path}/config/#{fname}.yml"
    end
    symlink_hash.each do |source, target|
      run "ln -s #{source} #{target}"
    end
  end

end

task :tail_log, :roles => :app do
  run "tail -f -n 100 #{shared_path}/log/#{rails_env}.log"
end

# symlink_shared
before "bundle:install", "deploy:symlink_shared"
# cleanup
after "deploy", "deploy:cleanup"

require 'puma/capistrano'