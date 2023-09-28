# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories/_form_modal.html.erb' do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'edit form modal' do
    let(:category_personal) { create(:category, :personal, user:) }

    before do
      render template: 'categories/_form_modal',
             locals: { target_id: dom_id(category_personal).to_s, modal_type: 'edit', category: category_personal }
    end

    it { expect(rendered).to have_content('Edit category') }
    it { expect(rendered).to have_xpath "//input[contains(@id, 'category_name')]" }
    it { expect(rendered).to have_button('Update Category') }
    it { expect(rendered).to have_button('Close') }
  end
end
