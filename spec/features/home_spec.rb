# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes' do
  describe 'start page' do
    before { visit root_path }

    it { expect(page).to have_xpath "//div[contains(@class, 'container')]" }
    it { expect(page).to have_link 'Event Planner' }
    it { expect(page).to have_link 'Language' }
    it { expect(page).to have_link 'Iorhael' }

    describe 'click on the app_name link' do
      before { click_link 'Event Planner' }

      it { expect(page).to have_current_path('/en') }
    end

    describe 'dropdown menu of language button' do
      before { click_link 'Language' }

      it { expect(page).to have_xpath "//ul[contains(@class,'dropdown-menu')]" }
    end
  end
end
