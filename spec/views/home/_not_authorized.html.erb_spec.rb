# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb' do
  before { render template: 'home/_not_authorized' }

  it { expect(rendered).to have_content('Event planner') }
  it { expect(rendered).to have_content('This application will help you efficiently organize your time') }
  it { expect(rendered).to have_link('Sign up') }
end
