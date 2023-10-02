# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let(:event) { create(:event, category:) }

  describe 'PATCH /events/:id' do
    subject(:update_event) { patch :update, params: { id: event, event: params } }

    context 'when user is not authenticated' do
      let(:params) { event.attributes.merge(name: 'valid name') }

      it 'return status 302' do
        update_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        update_event
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when category is not belong to current user' do
      let(:second_user) { create(:user) }
      let(:second_user_category) { create(:category, user: second_user) }
      let(:params) { event.attributes.merge(category_id: second_user_category) }

      before { sign_in(user) }

      it 'returns status 422' do
        update_event
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'set a flash message' do
        update_event
        expect(flash[:error]).to eq('Sorry, you trying to update event with unaccessible category')
      end

      it 'not update event in the database' do
        expect { update_event }.not_to(change { event.reload.category })
      end
    end

    context 'when user is authentificated and event params are valid' do
      let(:params) { event.attributes.merge(name: 'valid name') }

      before { sign_in(user) }

      it 'redirect to events_path' do
        update_event
        expect(response).to redirect_to(events_path)
      end

      it 'set a flash message' do
        update_event
        expect(flash[:success]).to eq('Event updated successfully')
      end

      it 'updates the event' do
        expect { update_event }.to change { event.reload.name }.to('valid name')
      end
    end

    context 'when user is authentificated and event params are not valid' do
      let(:params) { event.attributes.merge(name: '') }

      before { sign_in(user) }

      it 'redirect to events_path' do
        update_event
        expect(response).to redirect_to(events_path)
      end

      it 'does not update the event' do
        expect { update_event }.not_to(change { event.reload.name })
      end
    end
  end
end
