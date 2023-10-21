# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'GET /events/:id' do
    subject(:show_event) { get :show, params: { id: event } }

    context 'when user in not authenticated' do
      let(:event) { create(:event, category:) }

      it 'return status 302' do
        show_event
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        show_event
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when event does not exist for current user' do
      let(:second_user) { create(:user) }
      let(:second_user_category) { create(:category, user: second_user) }
      let(:event) { create(:event, category: second_user_category) }

      before { sign_in(user) }

      it 'raise ActiveRecord::RecordNotFound exception' do
        expect { show_event }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'when event in the past' do
      let(:event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

      before do
        event.save(validate: false)
        sign_in(user)
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'redirect to archive_path' do
        show_event
        expect(response).to redirect_to(archive_path(event))
      end

      it 'sets a flash info message' do
        show_event
        expect(flash[:info]).to match(I18n.t('flash.event.moved'))
      end
    end

    context 'when user is authenticated and event exists for current user' do
      let(:event) { create(:event, category:) }

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
