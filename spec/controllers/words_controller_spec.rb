require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  describe 'GET#index' do
    before do
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'GET#show' do
    let(:word) { create(:word) }
    before do
      get :show, params: { id: word.name }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end
end