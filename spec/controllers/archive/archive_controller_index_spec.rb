# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController do
  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }

  describe 'GET /archive' do
    let(:first_event) { build(:event, event_time: DateTime.now - 1.hour, category:) }
    let(:second_event) { build(:event, event_time: DateTime.now - 2.hours, category:) }

    before do
      first_event.save(validate: false)
      second_event.save(validate: false)
      get :index
    end

    context 'when user in not authenticated' do
      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
      end
    end

    context 'with event in the future' do
      let(:future_event) { create(:event, category:) }

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

      it 'not assigns future_event' do
        expect(assigns(:events)).not_to include(future_event)
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
