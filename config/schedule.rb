# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.

require File.expand_path("#{File.dirname(__FILE__)}/environment")

set :output, { error: 'log/cron_error_log.log', standard: 'log/cron_log.log' }

set :environment, ENV.fetch('RAILS_ENV')

every 1.minute do
  runner 'NotificationsSenderJob.perform_now'
end
