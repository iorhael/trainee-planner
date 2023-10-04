# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb' do
  let(:user) { create(:user, categories: [category]) }
  let(:category) { create(:category, events: [event_today, event_future]) }
  let(:event_today) { create(:event, event_time: DateTime.now.end_of_day) }
  let(:event_future) { create(:event, event_time: DateTime.now.tomorrow) }
  let(:counter) { UserServices::EventsCounter.new(user:) }

  before do
    sign_in(user)
    assign(:events_counter, counter)
    render template: 'home/_authorized'
  end

  it { expect(rendered).to have_content("Hello, #{user.first_name}") }
  it { expect(rendered).to have_content('You have 2 events in future (1 today)') }
end
