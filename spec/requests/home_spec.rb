# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes' do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user is not signed in' do
      before { get root_url }

      it 'redirect to sign in form' do
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context 'when user is loggedin' do
      before do
        sign_in user
        get root_url
      end

      it 'renders a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'renders _loggedin navbar' do
        expect(response).to render_template(:_loggedin)
      end
    end
  end
end
