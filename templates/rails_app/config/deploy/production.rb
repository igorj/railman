# production server configuration for capistrano
set :server, 'myproductionserver.com'
set :user, 'deploy'
server fetch(:server), user: fetch(:user), roles: %w{web app db}
