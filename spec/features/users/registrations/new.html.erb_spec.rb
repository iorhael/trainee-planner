# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User sign up process' do
  let(:user) { build(:user) }

  before { visit new_user_registration_path }

  describe 'when all data is valid' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
    end

    it { expect(page).to have_content('Welcome! You have signed up successfully.') }
  end

  describe 'when no first name' do
    before do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
    end

    it { expect(page).to have_content("First name can't be blank") }
  end

  describe 'when no email' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
    end

    it { expect(page).to have_content("Email can't be blank") }
  end

  describe 'when user with email existed' do
    let(:user) { create(:user) }

    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password
      click_button 'Sign up'
    end

    it { expect(page).to have_content('Email has already been taken') }
  end

  describe 'when no password' do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      click_button 'Sign up'
    end

    it { expect(page).to have_content("Password can't be blank") }
  end

  describe "when password confirmation doesn't match password" do
    before do
      fill_in 'First name', with: user.first_name
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: 'invalid_password_confirmation'
      click_button 'Sign up'
    end

    it { expect(page).to have_content("Password confirmation doesn't match Password") }
  end
end
