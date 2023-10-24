# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'DELETE /archive/:id' do
    subject(:delete_event) { delete :destroy, params: { id: event } }

    context 'when user is not authenticated' do
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

      before { event.save(validate: false) }

      it 'return status 302' do
        delete_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        delete_event
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
      end

      it 'does not delete event record' do
        expect { delete_event }.not_to change(Event, :count)
      end
    end

    context 'when event does not exist for current user' do
      let(:second_user) { create(:user) }
      let(:second_user_category) { create(:category, user: second_user) }
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category: second_user_category) }

      before do
        event.save(validate: false)
        sign_in(user)
      end

      it 'raise ActiveRecord::RecordNotFound exception' do
        expect { delete_event }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when event not in the past' do
      let(:event) { create(:event, category:) }

      before { sign_in(user) }

      it 'raise ActiveRecord::RecordNotFound exception' do
        expect { delete_event }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is authenticated and event exists for current user' do
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

      before do
        event.save(validate: false)
        sign_in(user)
      end

      it 'sets a flash notice message' do
        delete_event
        expect(flash[:info]).to match(I18n.t('flash.event.destroy'))
      end

      it 'delete event in the database' do
        expect { delete_event }.to change(Event, :count).by(-1)
      end
    end
  end
end
