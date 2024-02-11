# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/_about_event_widget.html.erb' do
  let(:category) { create(:category) }
  let(:event) { create(:event, :with_descriprition, category:) }

  before do
    assign(:event, event)
    render partial: 'about_event_widget'
  end

  it { expect(rendered).to have_content(I18n.t('shared.about_event_widget.about_event')) }
  it { expect(rendered).to have_content(I18n.l(event.event_time, format: :long)) }
  it { expect(rendered).to have_content(event.category.name) }
  it { expect(rendered).to have_content(event.description) }
  it { expect(rendered).to have_link(I18n.t('shared.about_event_widget.back_link')) }
end
