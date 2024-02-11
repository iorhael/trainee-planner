# frozen_string_literal: true

require 'rails_helper'

describe 'Events routes path', type: :routing do
  let(:event) { create(:event) }

  it 'routes events Events#index' do
    expect(get('/events')).to route_to(controller: 'events', action: 'index')
  end

  it 'routes show Events#show' do
    expect(get("/events/#{event.id}")).to route_to(controller: 'events',
                                                   action: 'show',
                                                   id: event.id.to_s)
  end

  it 'routes create Events#create' do
    expect(post('/events')).to route_to(controller: 'events', action: 'create')
  end

  it 'routes update Events#update' do
    expect(patch("/events/#{event.id}")).to route_to(controller: 'events',
                                                     action: 'update',
                                                     id: event.id.to_s)
  end

  it 'routes delete Events#destroy' do
    expect(delete("/events/#{event.id}")).to route_to(controller: 'events',
                                                      action: 'destroy',
                                                      id: event.id.to_s)
  end
end
