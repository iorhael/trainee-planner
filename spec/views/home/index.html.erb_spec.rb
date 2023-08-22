# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb' do
  before { render template: 'home/index' }

  it 'include empty div' do
    expect(rendered).to include('div', '')
  end
end
