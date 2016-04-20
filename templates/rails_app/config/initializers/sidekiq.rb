# Configure Sidekiq Redis connection to use the '<%= app_name %>' namespace
redis_config = { url: 'redis://localhost:6379', namespace: '<%= app_name %>' }
Sidekiq.configure_server { |config| config.redis = redis_config }
Sidekiq.configure_client { |config| config.redis = redis_config }

# Load the sidekiq-cron schedule
#Sidekiq::Cron::Job.load_from_hash! YAML.load_file('config/schedule.yml')


