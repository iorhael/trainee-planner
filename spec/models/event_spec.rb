# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event do
  subject(:event) { build(:event) }

  context 'when valid factory' do
    it { expect(event).to be_valid }
  end

  describe 'validations' do
    it { expect(event).to validate_presence_of :name }
    it { expect(event).to validate_presence_of :event_time }
  end

  describe 'event_time validations' do
    context 'when event_time is not nil and in the future' do
      let(:event) { build(:event, event_time: DateTime.tomorrow) }

      it { expect(event).to be_valid }
    end

    context 'when event_time in the past' do
      let(:event) { build(:event, event_time: DateTime.yesterday) }

      it { expect(event).not_to be_valid }

      it 'sets an error message for the event_time field' do
        event.validate

        expect(event.errors[:event_time]).to eq ["can't be in the past"]
      end
    end
  end

  describe 'reminder_time validations' do
    context 'when reminder_time before event_time and not in the past' do
      let(:event) { build(:event, event_time: DateTime.tomorrow + 1, reminder_time: DateTime.tomorrow) }

      it { expect(event).to be_valid }
    end

    context 'when reminder_time in the past' do
      let(:event) { build(:event, reminder_time: DateTime.yesterday) }

      it { expect(event).not_to be_valid }

      it 'sets an error message for the event_time field' do
        event.validate

        expect(event.errors[:reminder_time]).to eq ["can't be in the past"]
      end
    end

    context 'when reminder_time is after event_time' do
      let(:event) { build(:event, event_time: DateTime.tomorrow, reminder_time: DateTime.tomorrow + 1) }

      it { expect(event).not_to be_valid }

      it 'sets an error message for the event_time field' do
        event.validate

        expect(event.errors[:reminder_time]).to eq ["can't be after event time"]
      end
    end
  end

  describe 'traits' do
    describe 'with_descriprition' do
      let(:event) { build(:event, :with_descriprition) }

      it { expect(event.description).to be_a String }
    end

    describe 'with_reminder_time' do
      let(:event) { build(:event, :with_reminder_time) }

      it { expect(event.reminder_time).to eql(event.event_time - 1.hour) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'scopes' do
    describe '.ordered_by_time' do
      subject(:ordered_scope) { described_class.ordered_by_time(order) }

      let!(:late_event) { create(:event, event_time: DateTime.now + 2) }
      let!(:early_event) { create(:event, event_time: DateTime.now + 1) }

      context 'with :asc value' do
        let(:order) { :asc }

        it { expect(ordered_scope).to eq([early_event, late_event]) }
      end

      context 'with :desc value' do
        let(:order) { :desc }

        it { expect(ordered_scope).to eq([late_event, early_event]) }
      end
    end

    describe '.in_future' do
      subject(:in_future_scope) { described_class.in_future }

      let!(:past_event) { build(:event, event_time: DateTime.now - 2.hours) }
      let!(:future_event) { create(:event, event_time: DateTime.now + 1) }

      before { past_event.save(validate: false) }

      it { expect(in_future_scope).to include(future_event) }
      it { expect(in_future_scope).not_to include(past_event) }
    end

    describe '.in_past' do
      subject(:in_past_scope) { described_class.in_past }

      let!(:past_event) { build(:event, event_time: DateTime.now - 2.hours) }
      let!(:future_event) { create(:event, event_time: DateTime.now + 1) }

      before { past_event.save(validate: false) }

      it { expect(in_past_scope).to include(past_event) }
      it { expect(in_past_scope).not_to include(future_event) }
    end
  end
end
