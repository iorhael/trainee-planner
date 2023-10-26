# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.6'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Centralization of locale data collection for Ruby on Rails. [https://github.com/svenfuchs/rails-i18n]
gem 'rails-i18n'

# Validations for Active Storage [https://github.com/igorkasyanchuk/active_storage_validations]
gem 'active_storage_validations'

# Flexible authentication solution for Rails with Warden [https://github.com/heartcombo/devise]
gem 'devise'

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

# Bootstrap [https://github.com/twbs/bootstrap-rubygem]
gem 'bootstrap', '~> 5.3', '>= 5.3.1'

# Paginator for modern web app frameworks and ORMs [https://github.com/kaminari/kaminari]
gem 'kaminari'

# Makes consuming restful web services dead easy [https://github.com/jnunemaker/httparty]
gem 'httparty'

# Ruby method to print out time difference (duration) [https://github.com/tmlee/time_difference]
gem 'time_difference'

# Cron jobs in Ruby [https://github.com/javan/whenever]
gem 'whenever', require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # Factory_bot_rails provides Rails integration for factory_bot [https://github.com/thoughtbot/factory_bot_rails]
  gem 'factory_bot_rails'
  # Pry is a runtime developer console and IRB alternative [https://github.com/pry/pry]
  gem 'pry'
  # It's a library for generating fake data [https://github.com/faker-ruby/faker]
  gem 'faker'
  # A Ruby gem to load environment variables from `.env` [https://github.com/bkeepers/dotenv]
  gem 'dotenv-rails'
  # Ruby static code analyzer (a.k.a. linter) and code formatter [https://github.com/rubocop/rubocop]
  gem 'rubocop', require: false
  # Extension focused on enforcing Rails best practices and coding conventions [https://github.com/rubocop/rubocop-rails]
  gem 'rubocop-rails', require: false
  # Code style checking for RSpec files [https://github.com/rubocop/rubocop-rspec]
  gem 'rubocop-rspec', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # RSpec testing framework to Ruby on Rails [https://github.com/rspec/rspec-rails]
  gem 'rspec-rails'
  # Simple one-liner tests for common Rails functionality [https://github.com/thoughtbot/shoulda-matchers]
  gem 'shoulda-matchers', '~> 5.3'
  # Code coverage for Ruby [https://github.com/simplecov-ruby/simplecov]
  gem 'simplecov', require: false
  # Brings back `assigns` and `assert_template` to your Rails tests [https://github.com/rails/rails-controller-testing]
  gem 'rails-controller-testing'
  # Clean ActiveRecord databases [https://github.com/DatabaseCleaner/database_cleaner-active_record]
  gem 'database_cleaner-active_record'
  # Acceptance test framework for web applications [https://github.com/teamcapybara/capybara]
  gem 'capybara'
  # For web application testing [https://github.com/SeleniumHQ/selenium]
  gem 'selenium-webdriver'
  # Keep your Selenium WebDrivers updated automatically [https://github.com/titusfortner/webdrivers]
  gem 'webdrivers', '~> 5.0', require: false
  # Record your test suite's HTTP interactions and replay them during tests [https://github.com/vcr/vcr]
  gem 'vcr'
  # Library for stubbing and setting expectations on HTTP requests in Ruby [https://github.com/bblimke/webmock]
  gem 'webmock'
  # Providing time travel, freezing and acceleration capabilitie [https://github.com/travisjeffery/timecop]
  gem 'timecop'
end
