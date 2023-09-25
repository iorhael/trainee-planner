# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let!(:event) { create(:event, category:) }

  describe 'when user is authenticated' do
    before do
      login_as(user)
      visit events_path
    end

    it { expect(page).to have_button(I18n.t('events.index.create')) }
    it { expect(page).to have_content(I18n.t('events.index.title')) }
    it { expect(page).to have_content(event.name) }
    it { expect(page).to have_button(I18n.t('events.event.edit')) }
    it { expect(page).to have_button(I18n.t('events.event.delete')) }
  end

  describe 'when user is authenticated click add button' do
    before do
      login_as(user)
      visit events_path
      click_button 'Create event'
    end

    it { expect(page).to have_content(I18n.t('events.form_modal.create')) }
    it { expect(page).to have_content(I18n.t('events.table.name')) }
    it { expect(page).to have_content(I18n.t('events.table.event_time')) }
    it { expect(page).to have_content(I18n.t('events.table.reminder_time')) }
    it { expect(page).to have_content(category.name) }
    it { expect(page).to have_button(I18n.t('events.form_modal.close_btn')) }
  end

  describe 'when user is not authenticated' do
    before do
      visit events_path
    end

    it { expect(page).not_to have_content(event.name) }
    it { expect(page).not_to have_button(I18n.t('events.event.edit')) }
    it { expect(page).not_to have_button(I18n.t('events.event.delete')) }
  end
end
