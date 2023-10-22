# frozen_string_literal: true

module Weather
  class DataFetcher
    include HTTParty
    base_uri 'https://api.ambeedata.com/weather'
    headers 'x-api-key': ENV.fetch('AMBEE_API_KEY')

    def initialize(event_time:)
      @event_time = event_time
    end

    def call
      request_data
    end

    private

    attr_reader :event_time

    def request_data
      endpoint = event_time < next_hour_date ? '/history/by-lat-lng' : '/forecast/by-lat-lng'
      self.class.get(endpoint, build_options)
    end

    def build_options
      if event_time < next_hour_date
        options[:query].merge!(
          from: event_time.utc.beginning_of_hour.to_fs(:db),
          to: event_time.utc.beginning_of_hour.to_fs(:db)
        )
      end

      options
    end

    def next_hour_date
      @next_hour_date ||= (DateTime.now + 1.hour).beginning_of_hour
    end

    def options
      @options ||= {
        query: {
          lat: ENV.fetch('LAT'),
          lng: ENV.fetch('LNG'),
          units: 'si'
        }
      }
    end
  end
end
