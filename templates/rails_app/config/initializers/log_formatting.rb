# Logger formatter with timestamp and color
# source: https://cbpowell.wordpress.com/2013/08/09/beautiful-logging-for-ruby-on-rails-4
#

class ActiveSupport::Logger::SimpleFormatter
  SEVERITY_TO_COLOR_MAP = { 'DEBUG'=>'0;37', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'31', 'UNKNOWN'=>'37' }

  def call(severity, time, progname, msg)
    formatted_severity = sprintf("%-5s",severity)
    formatted_time = time.strftime("%d.%m.%Y %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)
    color = SEVERITY_TO_COLOR_MAP[severity]
    "\033[0;37m#{formatted_time}\033[0m [\033[#{color}m#{formatted_severity}\033[0m] #{msg.strip} (pid:#{$$})\n"
  end
end

# Use lograge to log single line per request
Rails.application.config.lograge.enabled = true
Rails.application.config.lograge.custom_options = lambda do |event|
  exceptions = %w(controller action format id)
  {
      params: event.payload[:params].except(*exceptions)
  }
end
