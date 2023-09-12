# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET index' do
    before { get :index }

    it 'returns a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'render index template' do
      expect(response).to render_template('index')
    end
  end
end
