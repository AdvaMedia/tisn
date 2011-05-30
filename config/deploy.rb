$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) 
require "rvm/capistrano"

set :whenever_command, "bundle exec whenever"
set :whenever_roles, :web
require "whenever/capistrano"


set :using_rvm, true
set :rvm_ruby_string, 'ruby-1.8.7-p334@tisn'

set :application, "tisn"

role :web, "95.141.193.62"                          # Your HTTP server, Apache/etc
set :user, 'advamedia' # пользователь удалённого сервера
set :use_sudo, false # не запускать команды под sudo

set :keep_releases, 1

set :app_dir, "/sites/advamedia.ru/#{application}/"

# Директория, куда будет делаться checkout из репозитория
set :deploy_to, "#{app_dir}deploy"

set :rails_env, "production"

# Настройки репозитория
set :scm, :git
set :repository, "git://github.com/AdvaMedia/tisn.git"
set :branch, "faq"
set :deploy_via, :remote_cache

after "deploy:setup" do
  run "mkdir -p #{deploy_to}/shared/pids && mkdir -p #{deploy_to}/shared/config && mkdir -p #{deploy_to}/shared/var"
end

before "deploy:update" do
  unicorn.stop
  ts.stop
end

after "deploy:update" do
  ts.conf
  ts.index
  ts.start    
  unicorn.start
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{deploy_to}/current && whenever --update-crontab #{application}"
  end
end

    

namespace :unicorn do
  task :start do
    run "cd #{deploy_to}/current && unicorn_rails -c #{deploy_to}/current/config/unicorn.rb -D -E #{rails_env}"
  end
 
  task :stop do
    run "kill -9 `cat #{deploy_to}/shared/pids/unicorn.pid`"
  end
 
  task :restart do
    run "kill -HUP `cat #{deploy_to}/shared/pids/unicorn.pid`"
  end
end

namespace :ts do
  [:index, :conf, :start, :stop].each do |ctask|
    task ctask do
      run "cd #{deploy_to}/current && rake ts:#{ctask.to_s} RAILS_ENV=#{rails_env}"
    end
  end
end
