# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#

APP_ROOT = File.expand_path('../..', __FILE__)

require 'dotenv'
Dotenv.load

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

environment ENV.fetch("RAILS_ENV") { "development" }

if ENV['UNICORN_BEHIND_NGINX']
  bind 'unix:///home/deploy/apps/<%= @config.app_name %>/puma.sock'

  # Specifies the number of `workers` to boot in clustered mode.
  # Workers are forked webserver processes. If using threads and workers together
  # the concurrency of the application would be max `threads` * `workers`.
  # Workers do not work on JRuby or Windows (both of which do not support
  # processes).
  #
  # Change WEB_CONCURRENCY to match your CPU core count
  workers ENV.fetch("WEB_CONCURRENCY") { 2 }

  # Use the `preload_app!` method when specifying a `workers` number.
  # This directive tells Puma to first boot the application and load code
  # before forking the application. This takes advantage of Copy On Write
  # process behavior so workers use less memory. If you use this option
  # you need to make sure to reconnect any threads in the `on_worker_boot`
  # block.
  #
  preload_app!

  # If you are preloading your application and using Active Record, it's
  # recommended that you close any connections to the database before workers
  # are forked to prevent connection leakage.
  #
  #before_fork do
  #  ActiveRecord::Base.connection_pool.disconnect!
  #  # disconnect from redis?
  #end

  # The code in the `on_worker_boot` will be called if you are using
  # clustered mode by specifying a number of `workers`. After each worker
  # process is booted, this block will be run. If you are using the `preload_app!`
  # option, you will want to use this block to reconnect to any threads
  # or connections that may have been created at application boot, as Ruby
  # cannot share connections between processes.
  #
  on_worker_boot do
    ActiveRecord::Base.establish_connection

    # digital ocean:
    #require "active_record"
    #ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
    #ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])

    # reconnect to redis?
  end
else
  port ENV.fetch("PORT") { 3000 }
end

stdout_redirect "#{APP_ROOT}/log/puma.stdout.log", "#{APP_ROOT}/log/puma.stderr.log", true

pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
# state_path "#{APP_ROOT}/tmp/pids/puma.state"
# activate_control_app

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
