# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET index' do
    let(:user) { create(:user) }

    render_views

    before { get :index }

    context 'when user is authentificated' do
      before { sign_in(user) }

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'render index template' do
        expect(response).to render_template('index')
      end
    end

    context 'when user is not authentificated' do
      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'render index template' do
        expect(response).to render_template('index')
      end

      it 'render welcome partial' do
        expect(response).to render_template(partial: '_welcome')
      end
    end
  end
end
