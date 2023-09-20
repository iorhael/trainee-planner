# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes' do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit root_path
  end

  describe 'app_name link' do
    before { click_link 'Event planner' }

    it { expect(page).to have_current_path('/en') }
  end

  describe 'dropdown menu of language button' do
    before { click_link 'Language' }

    it { expect(page).to have_xpath "//ul[contains(@class,'dropdown-menu')]" }
  end

  describe 'dropdown menu of profile avatar' do
    before { find('img').click }

    it { expect(page).to have_xpath "//ul[contains(@class,'dropdown-menu')]" }
  end
end
