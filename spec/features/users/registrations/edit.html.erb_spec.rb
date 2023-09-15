# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User edit profile process' do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit edit_user_registration_path
  end

  describe 'when change first_name' do
    before do
      fill_in 'First name', with: 'John'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content('Your account has been updated successfully.') }
  end

  describe 'when change last_name' do
    before do
      fill_in 'Last name', with: 'Doe'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content('Your account has been updated successfully.') }
  end

  describe 'when change password' do
    before do
      fill_in 'New password', with: 'new_password'
      fill_in 'Password confirmation', with: 'new_password'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content('Your account has been updated successfully.') }
  end

  describe 'when no current password' do
    before { click_button 'Update' }

    it { expect(page).to have_content("Current password can't be blank") }
  end

  describe 'when new password is not equal password confirmation' do
    before do
      fill_in 'New password', with: 'new_password'
      fill_in 'Password confirmation', with: 'invalid_password_confiramtion'
      fill_in 'Current password', with: user.password
      click_button 'Update'
    end

    it { expect(page).to have_content("Password confirmation doesn't match Password") }
  end

  describe 'when cancel account' do
    before do
      click_button 'Cancel my account'
    end

    it { expect(page).to have_current_path(user_session_path(locale: :en)) }
  end
end
