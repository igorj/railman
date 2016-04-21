require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_token]
Sidekiq::Web.set :sessions, Rails.application.config.session_options

# used to authenticate the user in sidekiq-web
class AdminConstraint
  def matches?(request)
    return false unless request.session[:user_id]
    # todo user = User.find request.session[:user_id]
    # todo user && user.admin?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' # todo , :constraints => AdminConstraint.new

  root 'home#index'
end
