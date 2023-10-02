# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/_no_events.html.erb' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    render template: 'events/_no_events'
  end

  it { expect(rendered).to have_content(I18n.t('events.no_events.empty')) }
  it { expect(rendered).to have_button(I18n.t('events.no_events.add')) }
end
