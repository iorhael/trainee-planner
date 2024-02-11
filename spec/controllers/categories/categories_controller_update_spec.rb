# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'PATCH /categories/:id' do
    subject(:update_category) { patch :update, params: { id: category, category: params } }

    context 'when user is not authenticated' do
      let(:params) { { name: 'valid name' } }

      it 'return status 302' do
        update_category
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        update_category
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
      end
    end

    context 'when user is authentificated and category params are valid' do
      let(:params) { { name: 'valid name' } }

      before { sign_in(user) }

      it 'redirect to categories_path' do
        update_category
        expect(response).to redirect_to(categories_path)
      end

      it 'set a flash message' do
        update_category
        expect(flash[:success]).to eq('Category updated successfully')
      end

      it 'updates the category' do
        expect { update_category }.to change { category.reload.name }.to('valid name')
      end
    end

    context 'when user is authentificated and category params are not valid' do
      let(:params) { { name: '' } }

      before { sign_in(user) }

      it 'redirect to categories_path' do
        update_category
        expect(response).to redirect_to(categories_path)
      end

      it 'does not update the category' do
        expect { update_category }.not_to(change { category.reload.name })
      end
    end
  end
end
