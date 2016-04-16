# Unicorn configuration

APP_ROOT = File.expand_path('../..', __FILE__)

require 'dotenv'
Dotenv.load

timeout Integer(ENV['UNICORN_TIMEOUT'])
if ENV['UNICORN_SOCK'] # behind nginx
  listen ENV['UNICORN_SOCK']
else
  listen Integer(ENV['UNICORN_PORT'])
end
worker_processes Integer(ENV['UNICORN_WORKERS'])
working_directory APP_ROOT
pid "#{APP_ROOT}/tmp/pids/unicorn.pid"

stderr_path "#{APP_ROOT}/log/unicorn.log"
stdout_path "/#{APP_ROOT}/log/unicorn.log"

# load the application in the master process before forking worker processes
preload_app true

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.
  old_pid = "#{APP_ROOT}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
