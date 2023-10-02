# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/show.html.erb' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  before do
    sign_in(user)
    assign(:event, event)
    render template: 'events/show'
  end

  it { expect(rendered).to have_content(event.name) }
end
