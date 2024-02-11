# frozen_string_literal: true

require 'rails_helper'

describe 'Categories routes path', type: :routing do
  let(:category) { create(:category) }

  it 'routes categories Categories#index' do
    expect(get('/categories')).to route_to(controller: 'categories', action: 'index')
  end

  it 'routes create Categories#create' do
    expect(post('/categories')).to route_to(controller: 'categories', action: 'create')
  end

  it 'routes update Categories#update' do
    expect(patch("/categories/#{category.id}")).to route_to(controller: 'categories',
                                                            action: 'update',
                                                            id: category.id.to_s)
  end

  it 'routes delete Categories#destroy' do
    expect(delete("/categories/#{category.id}")).to route_to(controller: 'categories',
                                                             action: 'destroy',
                                                             id: category.id.to_s)
  end
end
