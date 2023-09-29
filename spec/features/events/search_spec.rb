# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events buttons actions' do
  let(:user) { create(:user) }
  let(:category_rest) { create(:category, :rest, user:) }
  let(:category_work) { create(:category, :work, user:) }
  let!(:event_first_rest) { create(:event, name: 'first', category: category_rest) }
  let!(:event_second_rest) { create(:event, name: 'second', category: category_rest) }
  let!(:event_third_work) { create(:event, name: 'third', category: category_work) }

  before do
    login_as(user)
    visit events_path
  end

  describe 'search events with name first' do
    before do
      within '#events-search-form' do
        fill_in 'Name', with: 'first'
        select event_first_rest.category.name, from: 'category_name'
        click_button 'Search'
      end
    end

    it { expect(page).to have_content(event_first_rest.name) }
    it { expect(page).not_to have_content(event_second_rest.name) }
    it { expect(page).not_to have_content(event_third_work.name) }
  end

  describe 'search events with category name Rest' do
    before do
      within '#events-search-form' do
        select 'Rest', from: 'category_name'
        click_button 'Search'
      end
    end

    it { expect(page).to have_content(event_first_rest.name) }
    it { expect(page).to have_content(event_second_rest.name) }
    it { expect(page).not_to have_content(event_third_work.name) }
  end

  describe 'search events with non-existent name' do
    before do
      within '#events-search-form' do
        fill_in 'Name', with: 'non-existent name'
        select 'Rest', from: 'category_name'
        click_button 'Search'
      end
    end

    it { expect(page).to have_content(I18n.t('events.no_events.empty')) }
  end
end
