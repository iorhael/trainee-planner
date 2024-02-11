# frozen_string_literal: true

require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.redis = { host: ENV.fetch('REDIS_HOST', 'localhost'), db: ENV.fetch('SIDEKIQ_DB', 1) }
end

Sidekiq.configure_client do |config|
  config.redis = { host: ENV.fetch('REDIS_HOST', 'localhost'), db: ENV.fetch('SIDEKIQ_DB', 1) }
end
