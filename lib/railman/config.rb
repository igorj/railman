require 'yaml'

# Railman::Config contains configuration parameters used to generate the rails application
# It is saved in .railman in the generated application, so that it can be used to upgrade the application later.
module Railman
  class Config
    attr_accessor :version, :app_name, :class_name, :admin_email, :domain, :www_domain, :domains, :server
  end
end
