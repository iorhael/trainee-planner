# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event update process' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let!(:event) { create(:event, category:) }

  before do
    login_as(user)
    visit events_path
    click_button 'Edit'
  end

  describe 'update event with non-empty name' do
    before do
      within "#event_#{event.id}" do
        fill_in 'Name', with: 'valid name'
      end
      click_button 'Update Event'
    end

    it { expect(page).to have_content('Event updated successfully') }
    it { expect(page).to have_content('valid name') }
  end

  describe 'update event with empty name' do
    before do
      within "#event_#{event.id}" do
        fill_in 'Name', with: ''
      end
      click_button 'Update Event'
    end

    it { expect(page).to have_content("Name can't be blank") }
  end

  describe 'update event with empty event time' do
    before do
      within "#event_#{event.id}" do
        fill_in 'Event time', with: ''
      end
      click_button 'Update Event'
    end

    it { expect(page).to have_content("Event time can't be blank") }
  end

  describe 'update event with event time in the past' do
    before do
      within "#event_#{event.id}" do
        fill_in 'Event time', with: DateTime.now.yesterday
      end
      click_button 'Update Event'
    end

    it { expect(page).to have_content("Event time can't be in the past") }
  end

  describe 'update event with reminder time in the past' do
    before do
      within "#event_#{event.id}" do
        fill_in 'Reminder time', with: DateTime.now.yesterday
      end
      click_button 'Update Event'
    end

    it { expect(page).to have_content("Reminder time can't be in the past") }
  end

  describe 'update event with reminder time after event time' do
    before do
      within "#event_#{event.id}" do
        fill_in 'Reminder time', with: event.event_time + 1
      end
      click_button 'Update Event'
    end

    it { expect(page).to have_content("Reminder time can't be after event time") }
  end
end
