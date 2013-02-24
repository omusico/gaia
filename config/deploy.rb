require "rvm/capistrano"

require 'capistrano/ext/multistage'
require 'bundler/capistrano'
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

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

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => [:app] do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
  task :symlink_shared, :roles => [:app] do
    config_files = [:database, :airbrake, :email, :config]
    symlink_hash = {}
    config_files.each do |fname|
      symlink_hash["#{shared_path}/config/#{fname}.yml"] = "#{release_path}/config/#{fname}.yml"
    end
    symlink_hash.each do |source, target|
      run "ln -s #{source} #{target}"
    end
  end

  namespace :assets do

    desc <<-DESC
      Run the asset precompilation rake task. You can specify the full path \
      to the rake executable by setting the rake variable. You can also \
      specify additional environment variables to pass to rake via the \
      asset_env variable. The defaults are:

        set :rake,      "rake"
        set :rails_env, "production"
        set :asset_env, "RAILS_GROUPS=assets"
        set :assets_dependencies, fetch(:assets_dependencies) + %w(config/locales/js)
    DESC
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision) rescue nil
      if !from || capture("cd #{latest_release} && #{source.local.log(from)} #{assets_dependencies.join ' '} | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
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
