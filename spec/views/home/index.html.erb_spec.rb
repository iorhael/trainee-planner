# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb' do
  describe 'welcome message' do
    context 'when user sign in' do
      let(:user) { create(:user) }

      before do
        sign_in user
        render
      end

      it 'successfully welcomes user' do
        expect(rendered).to have_selector('h2', text: "Hello, #{user.first_name}")
      end
    end
  end
end
