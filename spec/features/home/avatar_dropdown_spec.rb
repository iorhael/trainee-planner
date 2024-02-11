# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Avatar dropdown actions' do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit root_path
    find(:css, "img[src*='human_avatar']").click
  end

  describe 'edit profile link' do
    before { click_link 'Edit profile' }

    it { expect(page).to have_current_path(edit_user_registration_path) }
  end

  describe 'sign out button' do
    before { click_button 'Sign out' }

    it { expect(page).to have_current_path(root_path) }
  end
end
