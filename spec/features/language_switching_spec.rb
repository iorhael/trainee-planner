# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Language switchings' do
  describe 'language link' do
    before { visit root_path }

    describe 'switch language to ru' do
      before do
        click_link 'Language'
        click_link 'RU'
      end

      it { expect(page).to have_link 'Язык' }
    end

    describe 'switch language to en' do
      before do
        click_link 'Language'
        click_link 'EN'
      end

      it { expect(page).to have_link 'Language' }
    end

    describe 'switch language to en after choosing ru' do
      before do
        click_link 'Language'
        click_link 'RU'
        click_link 'АНГ'
      end

      it { expect(page).to have_link 'Language' }
    end
  end
end
