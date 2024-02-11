# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/sessions/new.html.erb' do
  let(:user) { build(:user) }

  before do
    render template: 'users/sessions/new',
           locals: { resource: user, resource_name: :user, devise_mapping: Devise.mappings[:user] }
  end

  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_email')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_password')]" }
  it { expect(rendered).to have_xpath "//input[@type='checkbox']" }
  it { expect(rendered).to have_button 'Sign in' }
end
