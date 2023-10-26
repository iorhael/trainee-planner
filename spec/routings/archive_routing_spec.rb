# frozen_string_literal: true

require 'rails_helper'

describe 'Archive routes path', type: :routing do
  let(:event) { build(:event, event_time: DateTime.now - 2.hours) }

  before { event.save(validate: false) }

  it 'routes events Archive#index' do
    expect(get('/archive')).to route_to(controller: 'archive', action: 'index')
  end

  it 'routes show Archive#show' do
    expect(get("/archive/#{event.id}")).to route_to(controller: 'archive',
                                                    action: 'show',
                                                    id: event.id.to_s)
  end

  it 'routes delete Archive#destroy' do
    expect(delete("/archive/#{event.id}")).to route_to(controller: 'archive',
                                                       action: 'destroy',
                                                       id: event.id.to_s)
  end

  it 'routes delete_all Archive#destroy_all' do
    expect(delete('/archive/destroy_all')).to route_to(controller: 'archive',
                                                       action: 'destroy_all')
  end
end
