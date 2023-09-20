# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/registrations/edit.html.erb' do
  let(:user) { build(:user) }

  before do
    allow(view).to receive(:render).with(any_args).and_call_original
    allow(view).to receive(:render).with('users/shared/error_messages', resource: user)
    render template: 'users/registrations/edit',
           locals: { resource: user, resource_name: :user, devise_mapping: Devise.mappings[:user] }
  end

  it { expect(view).to have_received(:render).with('users/shared/error_messages', resource: user) }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_first_name')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_last_name')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_email')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_password')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_password_confirmation')]" }
  it { expect(rendered).to have_xpath "//input[contains(@id, 'user_current_password')]" }
  it { expect(rendered).to have_button 'Update' }
  it { expect(rendered).to have_button 'Cancel my account' }
  it { expect(rendered).to have_link 'Back' }
end
