# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes' do
  let(:user) { create(:user) }

  before { visit root_path }

  describe 'app_name link' do
    before { click_link 'Event planner' }

    it { expect(page).to have_current_path(root_path) }
  end

  describe 'dropdown menu of language button' do
    before { click_link 'Language' }

    it { expect(page).to have_xpath "//ul[contains(@class,'dropdown-menu')]" }
  end

  describe 'dropdown menu of profile avatar' do
    before do
      login_as(user)
      visit root_path
      find(:css, "img[src*='human_avatar']").click
    end

    it { expect(page).to have_xpath "//ul[contains(@class,'dropdown-menu')]" }
  end

  describe 'when user is not authenticated and sign up button clicked' do
    before do
      visit root_path
      within('.jumbotron') do
        click_link 'Sign up'
      end
    end

    it { expect(page).to have_current_path(new_user_registration_path) }
  end

  describe 'when user is not authenticated and sign in button clicked' do
    before do
      visit root_path
      within('.jumbotron') do
        click_link 'Sign in'
      end
    end

    it { expect(page).to have_current_path(new_user_session_path) }
  end
end
