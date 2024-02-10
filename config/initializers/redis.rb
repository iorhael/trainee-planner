# frozen_string_literal: true

REDIS = Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'), db: ENV.fetch('CACHE_DB', 0))
