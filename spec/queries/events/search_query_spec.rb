# frozen_string_literal: true

require 'rails_helper'

module Events
  RSpec.describe SearchQuery do
    let(:user) { create(:user) }
    let(:category) { create(:category, :rest, user:) }

    describe '#call' do
      subject(:returned_events) { described_class.new(search_params:, relation: user.events).call }

      let!(:event_first) { create(:event, name: 'first', category:) }
      let!(:event_second) { create(:event, name: 'second', category:) }

      context 'with non-existent name and category name' do
        let(:search_params) { { name: 'wrong name', category_name: 'wrong name' } }

        it { expect(returned_events).to eq([]) }
      end

      context 'with event name only' do
        let(:search_params) { { name: 'first' } }

        it { expect(returned_events).to eq([event_first]) }
      end

      context 'with partial event name' do
        let(:search_params) { { name: 'fir' } }

        it { expect(returned_events).to eq([event_first]) }
      end

      context 'with category name only' do
        let(:search_params) { { category_name: 'Rest' } }

        it { expect(returned_events).to eq([event_first, event_second]) }
      end

      context 'with name and category name' do
        let(:search_params) { { name: 'first', category_name: 'Rest' } }

        it { expect(returned_events).to eq([event_first]) }
      end
    end
  end
end
