# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/_events_search.html.erb' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    form_with url: events_path, method: :get do |form|
      render partial: 'events_search', locals: { f: form }
    end
  end

  it { expect(rendered).to have_xpath "//input[contains(@id, 'name')]" }
  it { expect(rendered).to have_xpath "//select[contains(@id, 'category_name')]" }
  it { expect(rendered).to have_button(I18n.t('shared.events_search.search')) }
end
