# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'dummy'
set :repo_url, "file:///#{File.expand_path("../../../dummy-repo", __FILE__)}"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# Each have their own setting

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, { path: "$PATH" }

set :rbenv_ruby, File.read(".ruby-version").chomp
# set :rbenv_path, "/usr/local/Cellar/rbenv/0.4.0"

# Default value for keep_releases is 5
# set :keep_releases, 5

before :deploy, :gitify_dummy do
  run_locally do
    with rails_env: ENV["RAILS_ENV"] do
      system "rake", "dummy:gitify"
    end
  end
end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
