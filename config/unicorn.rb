APP_PATH = File.expand_path('../../', __FILE__)

working_directory APP_PATH
listen            APP_PATH + '/tmp/sockets/unicorn.sock'
worker_processes  2
timeout           30
preload_app       true

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = APP_PATH + '/Gemfile'
end
