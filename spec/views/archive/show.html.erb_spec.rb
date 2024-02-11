# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'archive/show.html.erb' do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let(:event) { build(:event, :with_descriprition, event_time: DateTime.now - 2.hours, category:) }

  before do
    sign_in(user)
    assign(:event, event)
    allow(view).to receive(:render).with(any_args).and_call_original
    allow(view).to receive(:render).with(hash_including(partial: 'shared/about_event_widget'))
    render template: 'archive/show'
  end

  it 'renders about_event_widget' do
    expect(view).to have_received(:render).with(hash_including(partial: 'shared/about_event_widget'))
  end

  it { expect(rendered).to have_css("img[src*='archive']") }
end
