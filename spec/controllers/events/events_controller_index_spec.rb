# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'GET #index' do
    let(:first_event) { create(:event, event_time: DateTime.now + 1, category:) }
    let(:second_event) { create(:event, event_time: DateTime.now + 2, category:) }

    before { get :index }

    context 'when user in not authenticated' do
      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in(user)
        get :index
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders index template' do
        expect(response).to render_template('index')
      end

      it 'assigns @events' do
        expect(assigns(:events)).to eq([first_event, second_event])
      end
    end
  end
end
