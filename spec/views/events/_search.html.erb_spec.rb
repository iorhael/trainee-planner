# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/_search.html.erb' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    render template: 'events/_search'
  end

  it { expect(rendered).to have_xpath "//input[contains(@id, 'name')]" }
  it { expect(rendered).to have_xpath "//select[contains(@id, 'category_name')]" }
  it { expect(rendered).to have_button(I18n.t('events.search.search')) }
end
