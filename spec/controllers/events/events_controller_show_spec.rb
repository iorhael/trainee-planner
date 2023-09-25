# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }

  describe 'GET /events/:id' do
    subject(:show_event) { get :show, params: { id: event } }

    let(:event) { create(:event) }

    context 'when user in not authenticated' do
      it 'return status 302' do
        show_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        show_event
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'when user is authenticated' do
      before do
        sign_in(user)
        show_event
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders index template' do
        expect(response).to render_template('show')
      end

      it 'assigns @event' do
        expect(assigns(:event)).to eq(event)
      end
    end
  end
end
