# frozen_string_literal: true

require 'rails_helper'

describe 'Home routes path', type: :routing do
  it 'routes root path to home#index' do
    expect(get('/')).to route_to(controller: 'home', action: 'index')
  end

  it 'routes root path to locale en' do
    expect(get('/en')).to route_to(controller: 'home', action: 'index', locale: 'en')
  end

  it 'routes root path to locale ru' do
    expect(get('/ru')).to route_to(controller: 'home', action: 'index', locale: 'ru')
  end
end
