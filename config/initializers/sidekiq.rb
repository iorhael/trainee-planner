# frozen_string_literal: true

require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'), db: ENV.fetch('SIDEKIQ_DB', 1) }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'), db: ENV.fetch('SIDEKIQ_DB', 1) }
end
