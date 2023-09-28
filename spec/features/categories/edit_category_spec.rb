# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category update process' do
  let(:user) { create(:user) }
  let!(:category) { create(:category, user:) }

  before do
    login_as(user)
    visit categories_path
    click_button 'Edit'
  end

  describe 'update category with non-empty name' do
    before do
      within "#category_#{category.id}" do
        fill_in 'Name', with: 'valid name'
      end
      click_button 'Update Category'
    end

    it { expect(page).to have_content('Category updated successfully') }
  end

  describe 'update category with empty name' do
    before do
      within "#category_#{category.id}" do
        fill_in 'Name', with: ''
      end
      click_button 'Update Category'
    end

    it { expect(page).to have_content("Name can't be blank") }
  end

  describe 'update category with existing name' do
    before do
      create(:category, user:, name: 'name')
      within "#category_#{category.id}" do
        fill_in 'Name', with: 'name'
      end
      click_button 'Update Category'
    end

    it { expect(page).to have_content('Name has already been taken') }
  end
end
