# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'GET /archive/:id' do
    subject(:show_event) { get :show, params: { id: event } }

    context 'when user in not authenticated' do
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

      before { event.save(validate: false) }

      it 'return status 302' do
        show_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        show_event
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
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
        expect { show_event }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when event not in the past' do
      let(:event) { create(:event, category:) }

      before { sign_in(user) }

      it 'raise ActiveRecord::RecordNotFound exception' do
        expect { show_event }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user is authenticated and event exists for current user' do
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

      before do
        event.save(validate: false)
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
