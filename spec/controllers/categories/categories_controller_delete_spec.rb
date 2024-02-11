# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }

  describe 'DELETE /categories/:id' do
    subject(:delete_category) { delete :destroy, params: { id: category.id } }

    context 'when user is not authenticated' do
      it 'return status 302' do
        delete_category
        expect(response).to have_http_status(:found)
      end

      it 'redirect to sign in page' do
        delete_category
        expect(response).to redirect_to(new_user_session_path(locale: I18n.default_locale))
      end

      it 'does not delete category record' do
        expect { delete_category }.not_to change(Category, :count)
      end
    end

    context 'when user is authenticated' do
      before { sign_in(user) }

      it 'sets a flash notice message' do
        delete_category
        expect(flash[:info]).to match('Category deleted successfully')
      end

      it 'delete category in the database' do
        expect { delete_category }.to change(Category, :count).by(-1)
      end
    end
  end
end
