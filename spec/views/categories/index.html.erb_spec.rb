# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories/index.html.erb' do
  let(:category_personal) { create(:category, :personal, user:) }
  let(:category_work) { create(:category, :work, user:) }
  let(:category_rest) { create(:category, :rest, user:) }
  let(:categories) { [category_personal, category_work, category_rest] }
  let(:user) { create(:user) }

  before do
    sign_in(user)
    allow(view).to receive(:render).with(any_args).and_call_original
    allow(view).to receive(:render).with(hash_including(partial: 'form_modal'))
    assign(:categories, Kaminari.paginate_array(categories).page(1))
    render template: 'categories/index'
  end

  it 'renders partials' do
    expect(view).to have_received(:render).with(hash_including(partial: 'form_modal'))
                                          .exactly(1 + categories.count).times
  end

  it { expect(rendered).to have_content('Categories') }
  it { expect(rendered).to have_content('#') }
  it { expect(rendered).to have_content('Name') }
  it { expect(rendered).to include(CGI.escapeHTML(category_personal.name)) }
  it { expect(rendered).to include(CGI.escapeHTML(category_work.name)) }
  it { expect(rendered).to include(CGI.escapeHTML(category_rest.name)) }
  it { expect(rendered).to have_button 'Add category' }
end
