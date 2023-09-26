# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category buttons actions' do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user:) }

  before do
    login_as(user)
    visit categories_path
  end

  describe 'click edit button' do
    before { click_button 'Edit' }

    it { expect(page).to have_content('Edit category') }
    it { expect(page).to have_content(category.name) }
    it { expect(page).to have_button('Close') }
    it { expect(page).to have_button('Update Category') }
  end

  describe 'click delete button' do
    before { click_button 'Delete' }

    it { expect(page).to have_content("Looks like you don't have categories") }
    it { expect(page).to have_button('Add first category') }
  end
end
