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

  describe 'POST#create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          name: 'amor'
        }
      end

      it 'creates a new word' do
        VCR.use_cassette('search_for_love') do
          expect {
            post :create, xhr: true, params: valid_attributes
          }.to change(Word, :count)
        end
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          name: ''
        }
      end

      it 'does not create a new word' do
        VCR.use_cassette('search_for_empty_word') do
          expect {
            post :create, xhr: true, params: invalid_attributes
          }.not_to change(Word, :count)
        end
      end
    end
  end
end