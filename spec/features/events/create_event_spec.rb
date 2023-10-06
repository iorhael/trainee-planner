# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event create process' do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user:) }
  let(:event) { build(:event, category:) }

  before do
    login_as(user)
    visit events_path
    click_button 'Create event'
  end

  describe 'create event wiht valid attributes' do
    before do
      fill_in 'Name', with: event.name
      fill_in 'Event time', with: event.event_time
      select category.name, from: 'event_category_id'
      click_button 'Create Event'
    end

    it { expect(page).to have_content('Event created successfully') }
    it { expect(page).to have_content(event.name) }
    it { expect(page).to have_content(category.name) }
  end

  describe 'create event with empty name' do
    before do
      fill_in 'Event time', with: event.event_time
      select category.name, from: 'event_category_id'
      click_button 'Create Event'
    end

    it { expect(page).to have_content("Name can't be blank") }
  end

  describe 'create event with empty event time' do
    before do
      fill_in 'Name', with: event.name
      select category.name, from: 'event_category_id'
      click_button 'Create Event'
    end

    it { expect(page).to have_content("Event time can't be blank") }
  end

  describe 'create event with event time in the past' do
    before do
      fill_in 'Name', with: event.name
      fill_in 'Event time', with: DateTime.now.yesterday
      select category.name, from: 'event_category_id'
      click_button 'Create Event'
    end

    it { expect(page).to have_content("Event time can't be in the past") }
  end

  describe 'create event with reminder time in the past' do
    before do
      fill_in 'Name', with: event.name
      fill_in 'Event time', with: event.event_time
      fill_in 'Reminder time', with: DateTime.now.yesterday
      select category.name, from: 'event_category_id'
      click_button 'Create Event'
    end

    it { expect(page).to have_content("Reminder time can't be in the past") }
  end

  describe 'create event with reminder time after event time' do
    before do
      fill_in 'Name', with: event.name
      fill_in 'Event time', with: event.event_time
      fill_in 'Reminder time', with: event.event_time + 1
      select category.name, from: 'event_category_id'
      click_button 'Create Event'
    end

    it { expect(page).to have_content("Reminder time can't be after event time") }
  end
end
