# encoding: utf-8
# config valid only for Capistrano 3
lock '3.5.0'

# Project configuration options
# ------------------------------

set :application, 'listthis'
set :repo_url, "git@github.com:kaygorod/listthis.git"
set :deploy_to, "/var/www/listthis"
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :keep_releases, 3

namespace :deploy do
  %w[unicorn resque].each do |service|
    namespace service do
      %w[up down restart status].each do |command|
        desc "#{command.capitalize} #{service}"
        task command do
          on roles(:app) do
            execute "sudo sv #{command} #{fetch(:application)}_#{service}"
          end
        end
      end
    end
  end

  after :finished, 'unicorn:restart'
  after :finished, 'resque:restart'
end
