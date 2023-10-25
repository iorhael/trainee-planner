# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Archive' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let(:event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

  describe 'when user is authenticated' do
    before do
      event.save(validate: false)
      login_as(user)
      visit archive_index_path
    end

    it { expect(page).to have_content(I18n.t('archive.index.title')) }
    it { expect(page).to have_button(I18n.t('archive.table.delete_all_btn')) }
    it { expect(page).to have_content(event.name) }
    it { expect(page).to have_button(I18n.t('events.event.delete')) }
  end

  describe 'when user is authenticated and click delete button' do
    before do
      event.save(validate: false)
      login_as(user)
      visit archive_index_path
      click_button 'Delete'
    end

    it { expect(page).to have_content(I18n.t('events.no_events.empty')) }
    it { expect(page).to have_link(I18n.t('archive.index.back_link')) }
  end

  describe 'when user is authenticated and click delete all button' do
    let(:second_event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

    before do
      event.save(validate: false)
      second_event.save(validate: false)
      login_as(user)
      visit archive_index_path
      click_button 'Delete all'
    end

    it { expect(page).to have_content(I18n.t('events.no_events.empty')) }
    it { expect(page).to have_link(I18n.t('archive.index.back_link')) }
  end

  describe 'when user is authenticated and click event link' do
    before do
      event.save(validate: false)
      login_as(user)
      visit archive_index_path
      click_link event.name
    end

    it { expect(page).to have_current_path(archive_path(event)) }
  end

  describe 'when user is not authenticated' do
    before do
      visit archive_index_path
    end

    it { expect(page).not_to have_content(event.name) }
    it { expect(page).not_to have_button(I18n.t('events.event.delete')) }
  end
end
