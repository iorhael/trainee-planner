# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories/_no_categories.html.erb' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    render template: 'categories/_no_categories'
  end

  it { expect(rendered).to have_content("Looks like you don't have categories") }
  it { expect(rendered).to have_button('Add first category') }
end
