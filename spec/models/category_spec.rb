# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  subject(:category) { build(:category) }

  context 'when valid factory' do
    it { expect(category).to be_valid }
  end

  describe 'validations' do
    it { expect(category).to validate_presence_of :name }

    describe 'uniqueness validation' do
      subject(:category) { create(:category) }

      it { expect(category).to validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
    end
  end

  describe 'traits' do
    describe 'personal' do
      let(:category) { build(:category, :personal) }

      it { expect(category.name).to eql 'Personal' }
    end

    describe 'work' do
      let(:category) { build(:category, :work) }

      it { expect(category.name).to eql 'Work' }
    end

    describe 'rest' do
      let(:category) { build(:category, :rest) }

      it { expect(category.name).to eql 'Rest' }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { expect(category).to have_many(:events).dependent(:destroy) }
  end
end
