# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories/_category.html.erb' do
  let(:category_personal) { create(:category, :personal, user:) }
  let(:user) { create(:user) }

  before do
    sign_in(user)
    render template: 'categories/_category', locals: { category: category_personal, index: 1 }
  end

  it { expect(rendered).to include(CGI.escapeHTML(category_personal.name)) }
  it { expect(rendered).to have_button('Edit') }
  it { expect(rendered).to have_button('Delete') }
end
