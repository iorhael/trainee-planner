# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViewsImageHelper do
  describe '#part_of_day_image_path' do
    subject(:image_path) { part_of_day_image_path }

    after { Timecop.return }

    context 'when night' do
      before { Timecop.travel(DateTime.now.beginning_of_day + 1.hour) }

      it { expect(image_path).to eq('landscapes/night') }
    end

    context 'when morning' do
      before { Timecop.travel(DateTime.now.beginning_of_day + 7.hours) }

      it { expect(image_path).to eq('landscapes/morning') }
    end

    context 'when day' do
      before { Timecop.travel(DateTime.now.beginning_of_day + 13.hours) }

      it { expect(image_path).to eq('landscapes/day') }
    end

    context 'when evening' do
      before { Timecop.travel(DateTime.now.beginning_of_day + 19.hours) }

      it { expect(image_path).to eq('landscapes/evening') }
    end
  end
end
