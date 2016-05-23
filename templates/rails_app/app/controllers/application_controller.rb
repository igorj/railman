class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :error, :warning, :info
end
