# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/registrations/new.html.erb' do
  let(:user) { build(:user) }

  before do
    allow(view).to receive(:render).with(any_args).and_call_original
    allow(view).to receive(:render).with('users/shared/error_messages', resource: user)
    allow(view).to receive(:render).with('users/shared/links')
    render template: 'users/registrations/new',
           locals: { resource: user, resource_name: :user, devise_mapping: Devise.mappings[:user] }
  end

  it { expect(view).to have_received(:render).with('users/shared/error_messages', resource: user) }
  it { expect(view).to have_received(:render).with('users/shared/links') }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_first_name')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_last_name')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_email')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_password')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_password_confirmation')]" }
  it { expect(rendered).to have_button 'Sign up' }
end
