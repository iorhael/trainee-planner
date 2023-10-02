# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events buttons actions' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let!(:event) { create(:event, category:) }

  before do
    login_as(user)
    visit events_path
  end

  describe 'click edit button' do
    before { click_button 'Edit' }

    it { expect(page).to have_content(I18n.t('events.form_modal.edit')) }
    it { expect(page).to have_content(event.name) }
    it { expect(page).to have_content(event.category.name) }
    it { expect(page).to have_button(I18n.t('events.form_modal.close_btn')) }
    it { expect(page).to have_button(type: 'submit') }
  end

  describe 'click delete button' do
    before { click_button 'Delete' }

    it { expect(page).to have_content(I18n.t('events.no_events.empty')) }
    it { expect(page).to have_button(I18n.t('events.no_events.add')) }
  end
end
