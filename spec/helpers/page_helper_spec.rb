# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageHelper do
  describe '#record_index_with_pagination' do
    subject(:index_with_pagination) { record_index_with_pagination(index:, relation_class:) }

    let(:index) { 0 }
    let(:relation_class) { Category }

    context 'without params' do
      it { expect(index_with_pagination).to eq(index + 1) }
    end

    context 'with :page param' do
      before { controller.params[:page] = 2 }

      it { expect(index_with_pagination).to eq(relation_class.default_per_page + 1) }
    end

    context 'with :page and :per_page params' do
      before do
        controller.params[:page] = 2
        controller.params[:per_page] = 3
      end

      it { expect(index_with_pagination).to eq(4) }
    end
  end
end
