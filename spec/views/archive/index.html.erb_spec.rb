# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'archive/index.html.erb' do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:first_event) { build(:event, event_time: DateTime.now - 2.hours, category:) }
  let(:second_event) { build(:event, event_time: DateTime.now - 2.hours, category:) }
  let(:events) { [first_event, second_event] }

  before do
    first_event.save(validate: false)
    second_event.save(validate: false)
    sign_in(user)
  end

  context 'without events' do
    before do
      assign(:events, [])
      render template: 'archive/index'
    end

    it { expect(rendered).to have_content(I18n.t('events.no_events.empty')) }
    it { expect(rendered).to have_link(I18n.t('archive.index.back_link')) }
  end

  context 'with events' do
    before do
      allow(view).to receive(:render).with(any_args).and_call_original
      allow(view).to receive(:render).with(hash_including(partial: 'shared/events_search'))
      assign(:events, Kaminari.paginate_array(events).page(1))
      render template: 'archive/index'
    end

    it 'renders search' do
      expect(view).to have_received(:render).with(hash_including(partial: 'shared/events_search'))
    end

    it { expect(rendered).to have_content(I18n.t('archive.index.title')) }
    it { expect(rendered).to have_content('#') }
    it { expect(rendered).to have_content(I18n.t('events.table.name')) }
    it { expect(rendered).to have_content(I18n.t('events.table.category')) }
    it { expect(rendered).to have_content(I18n.t('events.table.event_time')) }
    it { expect(rendered).to have_button(I18n.t('archive.table.delete_all_btn')) }
    it { expect(rendered).to have_button(I18n.t('events.event.delete')).thrice }
    it { expect(rendered).to include(CGI.escapeHTML(first_event.name)) }
    it { expect(rendered).to include(CGI.escapeHTML(first_event.category.name)) }
    it { expect(rendered).to include(CGI.escapeHTML(I18n.l(first_event.event_time, format: :short))) }
    it { expect(rendered).to include(CGI.escapeHTML(second_event.name)) }
    it { expect(rendered).to include(CGI.escapeHTML(second_event.category.name)) }
    it { expect(rendered).to include(CGI.escapeHTML(I18n.l(second_event.event_time, format: :short))) }
  end
end
