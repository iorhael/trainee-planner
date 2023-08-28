# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event do
  subject(:event) { build(:event) }

  context 'when valid factory' do
    it { expect(event).to be_valid }
  end

  describe 'validations' do
    it { expect(event).to validate_presence_of :name }
    it { expect(event).to validate_presence_of :datetime }
  end

  describe 'traits' do
    describe 'with_descriprition' do
      let(:event) { build(:event, :with_descriprition) }

      it { expect(event.description).to be_a String }
    end

    describe 'with_reminder_time' do
      let(:event) { build(:event, :with_reminder_time) }

      it { expect(event.reminder_time).to eql event.datetime.next_day }
    end
  end

  describe 'associations' do
    let(:event) { build(:event) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end
end
