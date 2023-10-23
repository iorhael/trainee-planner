# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'DELETE /events/:id' do
    context 'when user is not authenticated' do
      subject(:delete_event) { delete :destroy, params: { id: event } }

      let!(:event) { create(:event, category:) }

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

    context 'when event does not exist for current user' do
      subject(:delete_event) { delete :destroy, params: { id: event } }

      let(:second_user) { create(:user) }
      let(:second_user_category) { create(:category, user: second_user) }
      let!(:event) { create(:event, category: second_user_category) }

      before { sign_in(user) }

      it 'raise ActiveRecord::RecordNotFound exception' do
        expect { delete_event }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is authenticated and event exists for current user' do
      subject(:delete_event) { delete :destroy, params: { id: event } }

      let!(:event) { create(:event, category:) }

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
