require 'rails_helper'

RSpec.describe '/sessions', type: :request do
  let(:valid_attributes) do
    {
      name: 'tunjit'
    }
  end

  let(:invalid_attributes) do
    {
      name: nil
    }
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_session_path
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'redirects to the articles url' do
        post sessions_url, params: { user: valid_attributes }
        expect(response).to redirect_to(articles_url)
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'new' template)" do
        post sessions_url, params: { user: invalid_attributes }
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete session_path(1)
      expect(response).to redirect_to(new_session_path)
    end
  end
end
