server '46.101.250.120', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:sargantanacode/sargantanacode.git'
set :application,     'sargantanacode'
set :user,            'sargantana'
set :puma_threads,    [0, 5]
set :puma_workers,    3

set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "tcp://0.0.0.0:9292 unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :keep_releases, 2

set :linked_files, %w{.env public/sitemap.xml.gz}
set :linked_dirs,  %w{public/packs node_modules public/uploads log public/sitemaps}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

Rake::Task["deploy:assets:precompile"].clear
Rake::Task["deploy:assets:backup_manifest"].clear

namespace :assets do
  desc "Precompile assets locally and then rsync to web servers"
  task :precompile do
    on roles(:web) do
      rsync_host = host.to_s
      run_locally do
        execute "rsync -av --delete ./public/packs/ #{fetch(:user)}@#{rsync_host}:#{shared_path}/public/packs/"
      end
    end
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke! 'puma:restart'
    end
  end

  before :starting, :check_revision
  after 'bundler:install', 'assets:precompile'
  after :finishing, 'sitemap:create'
  after :finishing, :cleanup
  after :finishing, :restart
end
