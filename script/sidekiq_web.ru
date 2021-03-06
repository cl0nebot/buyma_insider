require_relative '../config/application'

require 'sidekiq/web'
require 'sidekiq/cron/web'

# INFO: This share same connection pool as app,
#       might want to give a new pool, or additional connections
Sidekiq.configure_client { |cfg| cfg.redis = BuymaInsider.redis_for(:sidekiq) }
run Sidekiq::Web
