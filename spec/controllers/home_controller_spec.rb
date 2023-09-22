# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET index' do
    let(:user) { create(:user) }

    render_views

    context 'when user is authentificated' do
      before do
        sign_in(user)
        get :index
      end

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'render index template' do
        expect(response).to render_template('index')
      end

      it 'render authorized partial' do
        expect(response).to render_template(partial: '_authorized')
      end

      it 'assigns @counter' do
        expect(assigns(:events_counter)).to be_a(UserServices::EventsCounter)
      end
    end

    context 'when user is not authentificated' do
      before { get :index }

      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'render index template' do
        expect(response).to render_template('index')
      end

      it 'render not_authorized partial' do
        expect(response).to render_template(partial: '_not_authorized')
      end
    end
  end
end
