# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:category_work) { create(:category, :work, user:) }
    let(:category_personal) { create(:category, :personal, user:) }
    let(:category_rest) { create(:category, :rest, user:) }

    before { get :index }

    context 'when user in not authenticated' do
      it 'return status 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        expect(response).to redirect_to(new_user_session_path)
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

      it 'assigns @categories' do
        expect(assigns(:categories)).to eq([category_work, category_personal, category_rest])
      end
    end
  end
end
