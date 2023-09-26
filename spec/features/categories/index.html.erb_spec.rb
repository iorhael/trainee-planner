# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories' do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user:) }

  describe 'when user is authenticated' do
    before do
      login_as(user)
      visit categories_path
    end

    it { expect(page).to have_button('Add category') }
    it { expect(page).to have_content('Categories') }
    it { expect(page).to have_content(category.name) }
    it { expect(page).to have_button('Edit') }
    it { expect(page).to have_button('Delete') }
  end

  describe 'when user is authenticated click add button' do
    before do
      login_as(user)
      visit categories_path
      click_button 'Add category'
    end

    it { expect(page).to have_content('Add category') }
    it { expect(page).to have_content('Name') }
    it { expect(page).to have_button('Close') }
    it { expect(page).to have_button('Create Category') }
  end

  describe 'when user is not authenticated' do
    before do
      visit categories_path
    end

    it { expect(page).not_to have_content(category.name) }
    it { expect(page).not_to have_button('Edit') }
    it { expect(page).not_to have_button('Delete') }
  end
end
