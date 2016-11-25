class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  add_flash_types :success, :error, :warning, :info

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
