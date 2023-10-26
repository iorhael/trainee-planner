# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'DELETE /archive/destroy_all' do
    subject(:delete_all_events) { delete :destroy_all }

    let(:first_event) { build(:event, name: 'first', event_time: DateTime.now - 2.hours, category:) }
    let(:second_event) { build(:event, name: 'second', event_time: DateTime.now - 2.hours, category:) }

    before do
      first_event.save(validate: false)
      second_event.save(validate: false)
    end

    context 'when user is not authenticated' do
      it 'return status 302' do
        delete_all_events
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        delete_all_events
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
      end

      it 'does not delete event record' do
        expect { delete_all_events }.not_to change(Event, :count)
      end
    end

    context 'when event not in the past' do
      let(:event) { create(:event, category:) }

      before { sign_in(user) }

      it 'not delete event from database' do
        delete_all_events
        expect(Event.all).to include(event)
      end
    end

    context 'when event does not belong to current user' do
      let(:second_user) { create(:user) }
      let(:second_user_category) { create(:category, user: second_user) }
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category: second_user_category) }

      before do
        event.save(validate: false)
        sign_in(user)
      end

      it 'event not deleted' do
        delete_all_events
        expect(Event.all).to include(event)
      end
    end

    context 'with params' do
      subject(:delete_all_events_with_params) { delete :destroy_all, params: { name: 'first' } }

      before { sign_in(user) }

      it 'sets a flash notice message' do
        delete_all_events_with_params
        expect(flash[:info]).to match(I18n.t('flash.event.destroy_all'))
      end

      it 'delete event in the database' do
        expect { delete_all_events_with_params }.to change(Event, :count).by(-1)
      end

      it 'only second remained' do
        delete_all_events_with_params
        expect(Event.all).to eq([second_event])
      end
    end

    context 'when user is authenticated and events exists for current user' do
      before { sign_in(user) }

      it 'sets a flash notice message' do
        delete_all_events
        expect(flash[:info]).to match(I18n.t('flash.event.destroy_all'))
      end

      it 'delete event in the database' do
        expect { delete_all_events }.to change(Event, :count).by(-2)
      end
    end
  end
end
