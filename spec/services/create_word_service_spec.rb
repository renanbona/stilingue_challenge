require 'rails_helper'

describe CreateWordService do
  describe '.perform' do
    context 'When the word the searched word has related words' do
      it 'creates the word' do
        VCR.use_cassette('search_for_love') do
          described_class.perform('amor')

          expect(Word.count).to be >= 1
        end
      end

      it 'creates relationships for the word' do
        VCR.use_cassette('search_for_love') do
          described_class.perform('amor')

          expect(
            Word.find_by(name: 'amor')
              .associations
              .count
          ).to be >= 1
        end
      end
    end

    context 'When the word the searched word does not have related words' do
      it 'creates the word' do
        VCR.use_cassette('search_for_abacate') do
          described_class.perform('abacate')

          expect(Word.count).to be >= 1
        end
      end

      it 'does not creates relationships for the word' do
        VCR.use_cassette('search_for_love') do
          described_class.perform('abacate')

          expect(
            Word.find_by(name: 'abacate')
              .associations
              .count
          ).to eql(0)
        end
      end
    end
  end
end