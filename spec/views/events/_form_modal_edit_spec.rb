# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/_form_modal.html.erb' do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }

  before { sign_in(user) }

  describe 'edit form modal' do
    let(:event) { create(:event, category:) }

    before do
      render template: 'events/_form_modal',
             locals: { target_id: dom_id(event).to_s, modal_type: 'edit', event: }
    end

    it { expect(rendered).to have_content(I18n.t('events.form_modal.edit')) }
    it { expect(rendered).to have_xpath "//input[contains(@id, 'event_name')]" }
    it { expect(rendered).to have_xpath "//input[contains(@id, 'event_event_time')]" }
    it { expect(rendered).to have_xpath "//input[contains(@id, 'event_description')]" }
    it { expect(rendered).to have_xpath "//input[contains(@id, 'event_reminder_time')]" }
    it { expect(rendered).to have_xpath "//select[contains(@id, 'event_category_id')]" }
    it { expect(rendered).to have_button(type: 'submit') }
    it { expect(rendered).to have_button(I18n.t('events.form_modal.close_btn')) }
  end
end
