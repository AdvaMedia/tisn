set :application, "tisn.preview"

role :web, "advamedia.ru"                          # Your HTTP server, Apache/etc
set :user, 'advamedia' # пользователь удалённого сервера
set :use_sudo, false # не запускать команды под sudo

set :app_dir, "/home/#{user}/sites/advamedia/#{application}/"

# Директория, куда будет делаться checkout из репозитория
set :deploy_to, "#{app_dir}deploy"

# Настройки репозитория
set :scm, :git
set :repository, "git@rubylnik.ru:tisn.git"
set :branch, "faq"
set :deploy_via, :remote_cache