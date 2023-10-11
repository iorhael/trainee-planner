# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/show.html.erb' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let(:event) { create(:event, :with_descriprition, event_time: DateTime.now + 10.hours, category:) }

  before { sign_in(user) }

  context 'when whether presented' do
    let(:weather) { Weather::DataHandler.new(event_time: event.event_time).call }

    include_context 'with cassette', 'future_forecast'

    before do
      assign(:event, event)
      assign(:weather, weather)
      allow(view).to receive(:render).with(any_args).and_call_original
      allow(view).to receive(:render).with(hash_including(partial: 'weather_widget'))
      allow(view).to receive(:render).with(hash_including(partial: 'shared/about_event_widget'))
      render template: 'events/show'
    end

    it 'renders about_event_widget' do
      expect(view).to have_received(:render).with(hash_including(partial: 'shared/about_event_widget'))
    end

    it 'renders weather_widget' do
      expect(view).to have_received(:render).with(hash_including(partial: 'weather_widget'))
    end

    it { expect(rendered).to have_content(event.name) }
  end

  context 'when whether not presented' do
    before do
      assign(:event, event)
      allow(view).to receive(:render).with(any_args).and_call_original
      allow(view).to receive(:render).with(hash_including(partial: 'shared/about_event_widget'))
      render template: 'events/show'
    end

    it 'renders about_event_widget' do
      expect(view).to have_received(:render).with(hash_including(partial: 'shared/about_event_widget'))
    end

    it { expect(rendered).to have_content(event.name) }
    it { expect(rendered).to have_css("img[src*='landscape']") }
  end
end
