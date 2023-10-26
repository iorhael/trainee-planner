# frozen_string_literal: true

require 'rails_helper'

describe 'Users routes path', type: :routing do
  it 'routes sign in to DeviseSessions#new' do
    expect(get('/sign_in')).to route_to(controller: 'devise/sessions', action: 'new')
  end

  it 'routes sing up to UsersRegistrations#new' do
    expect(get('/sign_up')).to route_to(controller: 'users/registrations', action: 'new')
  end

  it 'routes edit to UsersRegistrations#edit' do
    expect(get('/edit')).to route_to(controller: 'users/registrations', action: 'edit')
  end
end
