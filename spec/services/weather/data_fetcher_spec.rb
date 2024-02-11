# frozen_string_literal: true

require 'rails_helper'

module Weather
  RSpec.describe DataFetcher do
    subject(:get_response) { described_class.new(event_time:).call }

    describe '#call' do
      context 'when event time in past later than 2 days' do
        let(:event_time) { DateTime.now - 90.hours }

        include_context 'with cassette', 'very_old_forecast'

        it { expect(get_response.code).to eq(400) }
      end

      context 'when event time in past less than 2 days' do
        let(:event_time) { DateTime.now - 2.hours }

        include_context 'with cassette', 'history_forecast'

        it { expect(get_response.code).to eq(200) }
        it { expect(get_response['data'].key?('history')).to be true }
      end

      context 'when event time within current hour' do
        let(:event_time) { DateTime.now.beginning_of_hour + 10.minutes }

        include_context 'with cassette', 'current_hour_forecast'

        it { expect(get_response.code).to eq(200) }
        it { expect(get_response['data'].key?('history')).to be true }
      end

      context 'when event time in future' do
        let(:event_time) { DateTime.now + 2.hours }

        include_context 'with cassette', 'future_forecast'

        it { expect(get_response.code).to eq(200) }
        it { expect(get_response['data'].key?('forecast')).to be true }
      end
    end
  end
end
