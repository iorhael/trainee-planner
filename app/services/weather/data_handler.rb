# frozen_string_literal: true

module Weather
  class DataHandler
    def initialize(event_time:)
      @event_time = event_time
    end

    def call
      fetch_with_cache
    end

    private

    attr_reader :event_time

    def fetch_with_cache
      cache_key = build_cache_key(event_time.beginning_of_hour.to_i)

      if (cached_data = Rails.cache.read(cache_key))
        decorate(cached_data)
      elsif (data = request_data)
        cache_forecast_data(data)
        decorate(data[hour_index.to_i])
      end
    end

    def request_data
      return if event_time.past? || event_time > next_hour_date + 48.hours

      response = DataFetcher.new(event_time:).call
      forecast(JSON.parse(response.body)) if [200, 206].include?(response.code)
    end

    def forecast(forecast_hash)
      return forecast_hash.dig('data', 'history') if event_time < next_hour_date

      forecast_hash.dig('data', 'forecast')
    end

    def decorate(data)
      Weather::ResponseDecorator.new(data:) if data.present?
    end

    def build_cache_key(timestamp)
      "weather_forecast/#{timestamp}"
    end

    def cache_forecast_data(data)
      data.each do |hourly_forecast|
        Rails.cache.write(build_cache_key(hourly_forecast['time']), hourly_forecast, expires_in: 1.day)
      end
    end

    def hour_index
      TimeDifference.between(event_time, next_hour_date).in_hours.to_i
    end

    def next_hour_date
      @next_hour_date ||= (DateTime.now + 1.hour).beginning_of_hour
    end
  end
end
