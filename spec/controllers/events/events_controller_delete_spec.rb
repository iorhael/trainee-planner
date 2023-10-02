# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }

  describe 'DELETE /events/:id' do
    subject(:delete_event) { delete :destroy, params: { id: event } }

    let!(:event) { create(:event) }

    context 'when user is not authenticated' do
      it 'return status 302' do
        delete_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        delete_event
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'does not delete event record' do
        expect { delete_event }.not_to change(Event, :count)
      end
    end

    context 'when user is authenticated' do
      before { sign_in(user) }

      it 'sets a flash notice message' do
        delete_event
        expect(flash[:info]).to match('Event deleted successfully')
      end

      it 'delete event in the database' do
        expect { delete_event }.to change(Event, :count).by(-1)
      end
    end
  end
end
