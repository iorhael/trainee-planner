# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category create process' do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit categories_path
    click_button 'Add first category'
  end

  describe 'create category with non-empty name' do
    before do
      fill_in 'Name', with: 'valid name'
      click_button 'Create Category'
    end

    it { expect(page).to have_content('Category created successfully') }
  end

  describe 'create category with empty name' do
    before do
      fill_in 'Name', with: ''
      click_button 'Create Category'
    end

    it { expect(page).to have_content("Name can't be blank") }
  end
end
