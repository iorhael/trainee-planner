# frozen_string_literal: true

require 'rails_helper'

module UserServices
  RSpec.describe EventsCounter do
    subject(:counter_service) { described_class.new(user:) }

    let(:user) { create(:user) }
    let(:category) { create(:category, user:) }

    describe '#in_future' do
      context 'when user has events in future' do
        before { create_list(:event, 2, event_time: DateTime.now.tomorrow, category:) }

        it { expect(counter_service.in_future).to eq(2) }
      end

      context 'when user has no events in future' do
        it { expect(counter_service.in_future).to eq(0) }
      end
    end

    describe '#today' do
      context 'when user has events today' do
        before { create_list(:event, 2, event_time: DateTime.now.end_of_day, category:) }

        it { expect(counter_service.in_future).to eq(2) }
      end

      context 'when user has no events today' do
        it { expect(counter_service.in_future).to eq(0) }
      end
    end
  end
end
