# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { create(:user) }

  describe 'POST /categories/new' do
    subject(:create_category) { post :create, params: { category: params } }

    context 'when user is not authenticated' do
      let(:params) { { name: 'valid name' } }

      it 'return status 302' do
        create_category
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        create_category
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
      end
    end

    context 'when user is authentificated and category params are valid' do
      let(:params) { { name: 'valid name' } }

      before { sign_in(user) }

      it 'redirect to categories_path' do
        create_category
        expect(response).to redirect_to(categories_path)
      end

      it 'set a flash message' do
        create_category
        expect(flash[:success]).to eq('Category created successfully')
      end

      it 'save category to the database' do
        expect { create_category }.to change(Category, :count).by(1)
      end
    end

    context 'when user is authentificated and category params are not valid' do
      let(:params) { { name: '' } }

      before { sign_in(user) }

      it 'redirect to categories_path' do
        create_category
        expect(response).to redirect_to(categories_path)
      end

      it 'not save category to the database' do
        expect { create_category }.not_to change(Category, :count)
      end
    end
  end
end
