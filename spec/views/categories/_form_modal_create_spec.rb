# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories/_form_modal.html.erb' do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'create form modal' do
    before do
      render template: 'categories/_form_modal',
             locals: { target_id: 'new-category-modal', modal_type: 'create', category: Category.new }
    end

    it { expect(rendered).to have_content('Create category') }
    it { expect(rendered).to have_xpath "//input[contains(@id, 'category_name')]" }
    it { expect(rendered).to have_button('Create Category') }
    it { expect(rendered).to have_button('Close') }
  end
end
