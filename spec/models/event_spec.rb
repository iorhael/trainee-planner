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

        expect(event.errors[:reminder_time]).to eq ["can't be after event_time"]
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
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end
end