require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_token]
Sidekiq::Web.set :sessions, Rails.application.config.session_options

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
end
