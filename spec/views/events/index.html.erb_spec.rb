# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/index.html.erb' do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:first_event) { create(:event, category:) }
  let(:second_event) { create(:event, category:) }
  let(:events) { [first_event, second_event] }

  before do
    sign_in(user)
    allow(view).to receive(:render).with(any_args).and_call_original
    allow(view).to receive(:render).with(hash_including(partial: 'form_modal'))
    allow(view).to receive(:render).with(hash_including(partial: 'shared/events_search'))
    assign(:events, Kaminari.paginate_array(events).page(1))
    render template: 'events/index'
  end

  it 'renders modals' do
    expect(view).to have_received(:render).with(hash_including(partial: 'form_modal'))
                                          .exactly(1 + events.count).times
  end

  it 'renders search' do
    expect(view).to have_received(:render).with(hash_including(partial: 'shared/events_search'))
  end

  it { expect(rendered).to have_content(I18n.t('events.index.title')) }
  it { expect(rendered).to have_content('#') }
  it { expect(rendered).to have_content(I18n.t('events.table.name')) }
  it { expect(rendered).to have_content(I18n.t('events.table.category')) }
  it { expect(rendered).to have_content(I18n.t('events.table.event_time')) }
  it { expect(rendered).to include(CGI.escapeHTML(first_event.name)) }
  it { expect(rendered).to include(CGI.escapeHTML(first_event.category.name)) }
  it { expect(rendered).to include(CGI.escapeHTML(I18n.l(first_event.event_time, format: :short))) }
  it { expect(rendered).to include(CGI.escapeHTML(second_event.name)) }
  it { expect(rendered).to include(CGI.escapeHTML(second_event.category.name)) }
  it { expect(rendered).to include(CGI.escapeHTML(I18n.l(second_event.event_time, format: :short))) }
  it { expect(rendered).to have_button I18n.t('events.table.create') }
end
