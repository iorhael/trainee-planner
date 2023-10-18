# frozen_string_literal: true

module Weather
  class ResponseDecorator
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def summary
      @summary ||= data['summary']
    end

    def temperature
      @temperature ||= data['temperature']
    end

    def humidity
      @humidity ||= data['humidity']
    end

    def pressure
      @pressure ||= data['pressure']
    end

    def wind_speed
      @wind_speed ||= data['windSpeed']
    end
  end
end
