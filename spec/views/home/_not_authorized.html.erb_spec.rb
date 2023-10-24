# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb' do
  before { render template: 'home/_not_authorized' }

  it { expect(rendered).to have_content(I18n.t('home.not_authorized.welcome')) }
  it { expect(rendered).to have_content(I18n.t('home.not_authorized.description')) }
  it { expect(rendered).to have_content(I18n.t('home.not_authorized.next')) }
  it { expect(rendered).to have_link('Sign up') }
  it { expect(rendered).to have_link('Sign in') }
  it { expect(rendered).to have_css("img[src*='hello']") }
end
