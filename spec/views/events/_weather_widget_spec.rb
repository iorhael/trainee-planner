# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/_weather_widget.html.erb' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let(:event) { create(:event, event_time: DateTime.now + 10.hours, category:) }
  let(:weather) { Weather::DataHandler.new(event_time: event.event_time).call }

  include_context 'with cassette', 'future_forecast'

  before { sign_in(user) }

  context 'when whether presented' do
    let(:event_time) { DateTime.now + 2.hours }

    before do
      assign(:event, event)
      assign(:weather, weather)
      render partial: 'events/weather_widget'
    end

    it { expect(rendered).to have_content(I18n.t('events.weather_widget.example_city')) }
    it { expect(rendered).to have_content(event.event_time.to_fs(:time)) }
    it { expect(rendered).to have_content(weather.summary) }
    it { expect(rendered).to have_content(weather.temperature) }
    it { expect(rendered).to have_content(weather.wind_speed) }
    it { expect(rendered).to have_content(weather.humidity) }
    it { expect(rendered).to have_content(weather.pressure) }
    it { expect(rendered).to have_css("img[src*='weather_icon']") }
  end
end
