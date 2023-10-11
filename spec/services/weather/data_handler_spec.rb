# frozen_string_literal: true

require 'rails_helper'

module Weather
  RSpec.describe DataHandler do
    subject(:get_weather_object) { described_class.new(event_time:).call }

    describe '#call' do
      context 'when event time in past' do
        let(:event_time) { DateTime.now - 2.hours }

        it { expect(get_weather_object).to be_nil }
      end

      context 'when event time in future less than 48 hours' do
        let(:event_time) { DateTime.now + 2.hours }

        include_context 'with cassette', 'future_forecast'

        it { expect(get_weather_object).to be_a ResponseDecorator }
      end

      context 'when event time in future more than 48 hours' do
        let(:event_time) { DateTime.now + 90.hours }

        it { expect(get_weather_object).to be_nil }
      end
    end
  end
end
