# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'POST /events/new' do
    subject(:create_event) { post :create, params: { event: params } }

    context 'when user is not authenticated' do
      let(:params) { attributes_for(:event).merge({ category_id: category }) }

      it 'return status 302' do
        create_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        create_event
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when category is not belong to current user' do
      let(:second_user) { create(:user) }
      let(:second_user_category) { create(:category, user: second_user) }
      let(:params) { attributes_for(:event).merge({ category_id: second_user_category }) }

      before { sign_in(user) }

      it 'returns status 422' do
        create_event
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'set a flash message' do
        create_event
        expect(flash[:error]).to eq('Sorry, you trying to create event with unaccessible category')
      end

      it 'not save event to the database' do
        expect { create_event }.not_to change(Event, :count)
      end
    end

    context 'when user is authentificated and category params are valid' do
      let(:params) { attributes_for(:event).merge({ category_id: category }) }

      before { sign_in(user) }

      it 'redirect to events_path' do
        create_event
        expect(response).to redirect_to(events_path)
      end

      it 'set a flash message' do
        create_event
        expect(flash[:success]).to eq('Event created successfully')
      end

      it 'save event to the database' do
        expect { create_event }.to change(Event, :count).by(1)
      end
    end

    context 'when user is authentificated and event params are not valid' do
      let(:params) { attributes_for(:event).merge({ name: '', category_id: category }) }

      before { sign_in(user) }

      it 'redirect to events_path' do
        create_event
        expect(response).to redirect_to(events_path)
      end

      it 'not save event to the database' do
        expect { create_event }.not_to change(Event, :count)
      end
    end
  end
end
